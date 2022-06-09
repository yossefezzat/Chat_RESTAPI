class MessageCreationWorker

  include Sidekiq::Worker

  def perform(app_key, chat_number, body, message_number)
    application = Application.find_by!(app_key: app_key)
    chat = application.chats.find_by!(number: chat_number)
    chat.messages.create!(number: message_number, body: body)
  end
end
