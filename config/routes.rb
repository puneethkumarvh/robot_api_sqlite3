Rails.application.routes.draw do
  post 'robot/orders' => 'robot#orders'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
