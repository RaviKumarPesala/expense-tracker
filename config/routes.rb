Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    resources :employee do
      resources :expense
    end
    resources :expense_comment
    scope '/reimbursement' do
      get 'expenses', action: :reiumbersement_expenses, controller: 'admin_approval'
      get 'expense/:id', action: :reiumbersement_expense, controller: 'admin_approval'
      put 'expense/:id', action: :update_expense_status, controller: 'admin_approval'
    end
  end
end
