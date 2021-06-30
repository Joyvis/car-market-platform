Rails.application.routes.draw do
  get 'users/:user_id/cars', to: 'users/cars#index'
end
