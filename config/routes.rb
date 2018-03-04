Rails.application.routes.draw do
  resources :companies
  root to: redirect(path: 'companies')
end
