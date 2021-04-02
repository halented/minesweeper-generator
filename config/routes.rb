Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards, only: [:index, :show, :new, :create]

  get '/', :to => 'boards#new'

  if Rails.env.production?
    get '404', :to => 'application#page_not_found'
  end

end
