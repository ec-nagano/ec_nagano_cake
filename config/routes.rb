Rails.application.routes.draw do
  #devise_for :admins
  #devise_for :customers

  namespace :admin do
  	devise_for :admins, controllers: {
  		sessions: 'admin/admins/sessions',
  		passwords: 'admmin/admins/passwords',
  		registrations: 'admin/admins/registrations'
  	}
  end
  devise_for :customers, controllers: {
  	sessions: 'customers/sessions',
  	passwords: 'customers/passwords',
  	registrations: 'customers/registrations'
  }
  # 顧客側
  # homesコントローラー
  get '/' => 'homes#top'
  get 'about' => 'homes#about'
  # customersコントローラ-
  get '/customers/confim_unsubscribing' => 'customers#confirm_unsubscribing'
  get 'customers/:id' => 'customers#show'

  # shipping_addressesコントローラ
  resources :shipping_addresses, only: [:index, :edit, :update, :destroy, :create]
  #productsコントローラ
  resources :products, only: [:index, :show]
  # cart_itemsコントローラ
  resources :cart_items, only: [:index, :create, :destroy, :update]
  delete 'cart_items' => 'cart_items#items_destroy'
  # ordersコントローラ
  resources :orders, only: [:index, :show, :new, :create]
  post 'orders/cofirm' => 'orders#confirm'
  get 'orders/thanks' => 'orders#thanks'
  # 管理側
  namespace :admin do
	  # admin/admins(devise)コントローラ
	  get '/' => 'homes#top'
	  # admin/productsコントローラ
	  resources :products, only: [:index, :new, :show, :edit, :create, :update]
	  # admin/categoriesコントローラ
	  resources :categories, only: [:index, :edit, :create, :update]
	  # admin/customersコントローラ
	  resources :customers, only: [:index, :show, :edit, :update]
	  # admin/ordersコントローラ
	  resources :orders, only: [:index, :show, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
