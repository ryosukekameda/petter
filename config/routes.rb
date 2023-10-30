Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only:[:index, :show, :edit, :update]
  end
  
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
  
  
  resource :users, only: [] do
    member do
      get 'account_id', action: :show
      get 'account_id/edit', action: :edit
      patch '', action: :update
      get 'unsubscribe'
      patch 'withdraw'
    end
  end
  
    resources :posts, only: [:show, :create, :destroy] 
    resources :favorites, only: [:create, :destroy] 
    resources :comments, only: [:create, :destroy] 
    resources :reports, only: [:new, :create] 
    
    resources :relationships, only: [:create, :destroy] 
      get 'user_id/followings' => 'user_id#followings', as: 'user_id_followings'
      get 'user_id/followers' => 'user_id#followers', as: 'user_id_followers'
  end
  
end
