Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      devise_for :users, controllers: { registrations: 'api/v1/registrations', sessions: 'api/v1/sessions' }, skip: [:password] 
      resources :authentication do
        collection do
          post 'verify_otp'
        end  
      end
    end 
  end  
end
