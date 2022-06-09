class ChatCreationWorker
  include Sidekiq::Worker

  def perform(app_key, chat_count)
    @application = Application.find_by_app_key!(app_key)
    @application.chats.create!(number: chat_count)  # need a queue for chat creation endpoint
    REDIS.HSET(@application.app_key, chat_count, 0)   # set key of chat created to be increment later by message value
  end
end
