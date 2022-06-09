class Message < ApplicationRecord
    belongs_to :chat

    validates :number,
            presence: true,
            numericality: { only_integer: true },
            uniqueness: {
                scope: [:chat_id]
            }
    validates :body, presence: true

    def as_json(options={})
        super(options.merge({except: [:id, :chat_id]}))
    end
end
