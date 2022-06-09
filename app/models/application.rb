class Application < ApplicationRecord
    has_secure_token :app_key

    has_many :chats, dependent: :destroy
  
    validates :name, presence: true
    
    def as_json(options={})
        super(options.merge({except: :id}))
    end

end
