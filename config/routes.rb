Rails.application.routes.draw do
  resources :companies do
    resources :employees
  end
  root to: redirect(path: 'companies')
end
