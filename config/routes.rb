Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    sessions: 'auth/sessions',
    passwords: 'auth/passwords'
  }

  resources :transactions, except: %i[destroy]

  root to: 'transactions#index'
end
