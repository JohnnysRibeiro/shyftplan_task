Rails.application.routes.draw do
  resources :companies
  get 'companies_without_required_employees', to: 'companies#companies_without_required_employees', defaults: { format: :json }
  resources :employees
end
