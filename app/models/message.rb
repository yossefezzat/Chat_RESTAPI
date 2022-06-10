class Message < ApplicationRecord
    
    belongs_to :chat

    validates :number,
    presence: true,
    numericality: { only_integer: true },
    uniqueness: {
        scope: [:chat_id]
    }
    validates :body, presence: true
    
    # The false option for the dynamic setting will still accept documents that have fields which are not in the mapping
    
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name Rails.application.class.parent_name.underscore
    document_type self.name.downcase

    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
            # indexes :number, type: :long
            indexes :chat_id, type: :long
            indexes :app_key, type: :string
            indexes :body, analyzer: 'english'
        end
    end

    def self.search(query)
        __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['body']
                }
            },
        }
    )
end

def as_json(options={})
    super(options.merge({except: [:id, :chat_id]}))
end

def as_indexed_json(options = nil)
    self.as_json( only: [ :app_key, :chat_id, :number, :body ] )
    end
end
