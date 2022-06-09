class UpdateChatsCountWorker
  include Sidekiq::Worker

  def perform(*args)
    Application.all.each do|app|
      app.chat_count = app.chats.count
      app.save
    end
  end
end
