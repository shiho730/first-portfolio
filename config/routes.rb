Rails.application.routes.draw do

  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  scope module: :public do
    get 'customers/quit'
    patch 'customers/out'
    resource :customers, only: [:show, :edit, :update] do
      resource :likes, only: [:create, :destroy]
    end
  end

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    resources :ordered_items, only: [:update]
  end

  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update]
  end

  namespace :admin do
    root to: 'top#top'
  end

  scope module: :public do
    get 'orders/information'
    post 'orders/confirm'
    get 'orders/thanks'
    resources :orders, only: [:create, :index, :show, :new]
  end

  scope module: :public do
    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  scope module: :public do
    resources :cart_items, only: [:index, :create, :destroy, :update]
    delete 'cartitems' => 'cart_items#destroy_all'
  end

  namespace :admin do
    resources :items, only: [:index, :create, :new, :update, :show, :edit]
  end

  scope module: :public do
    root 'items#top'
    get 'about' => 'items#about'
    get 'rank' => 'items#rank'
    get 'items/genre/:genre_id' => 'items#genre', as: "genre"
    resources :items, only: [:index, :show] do
      resource :likes, only: [:create, :destroy, :index]
    end
  end

  scope module: :public do
    resources :reviews, only: [:create, :destroy, :update, :index, :show]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
