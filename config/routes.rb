Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :test
  namespace :api do
    namespace :v1 do
      resources :applications, only: [:index, :show, :create], param: :app_key do
        member do
          resources :chats, only: [:index, :show, :create], param: :chat_number do
            member do
              resources :messages, only: [:index, :create]
            end  
          end
        end
      end
    end
  end
end
