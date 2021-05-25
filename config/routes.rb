Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users,  path: '', controllers: {
    sessions: 'auth/sessions',
    passwords: 'auth/passwords'
  }, path_names: { sign_in: 'login', password: 'forgot', sign_out: 'logout' }

  resources :transactions, except: %i[destroy]

  root to: 'transactions#index'
end
