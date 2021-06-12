Rails.application.routes.draw do
  resources :companies do
    resources :employees
  end
  get 'companies_without_required_employees', to: 'companies#companies_without_required_employees', defaults: { format: :json }
end
