Rails.application.reloader.to_prepare do
    Sidekiq::Cron::Job.create(name: "Update apps' chats_count - every 1hr", cron: '*/50 * * * *' , class: 'UpdateChatsCountWorker')
    Sidekiq::Cron::Job.create(name: "Update chats' messages_count - every 1hr", cron: '*/52 * * * *' , class: 'UpdateMessagesCountWorker')
end
