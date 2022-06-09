class UpdateMessagesCountWorker
  include Sidekiq::Worker

  def perform(*args)
    Chat.all.each do |chat|
      chat.message_count = chat.messages.count
      chat.save
    end
  end
end
