Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, as: nil, defaults: { format: 'json' } do
    namespace :v1, as: nil do
      namespace :users do
        post :social_media_login,  to: 'sessions#social_media_login', as: 'social_media_login'
        post 'authenticate',  to: 'sessions#create', as: 'login'
        post 'sign_up',       to: 'registration#create', as: 'sign_up'
        post 'password_resets', to: 'password_resets#create', as: 'password_resets'
        get 'password_resets/:token/edit', to: 'password_resets#edit', as: 'edit_password_resets'
        put 'password_resets/:token', to: 'password_resets#update', as: 'update_password_resets'
        get 'confirmations/:token', to: 'confirmations#show', as: 'confirmations'
        get 'account_profile', to: 'users#account_profile'
        patch 'update_password', to: 'users#update_password'
        patch 'update_profile', to: 'users#update_profile'
        resources :users, only: [] do
          collection do
            get :notification
          end
        end
      end

      resources :products do
        collection do
          get :search
        end
      end

      get 'about_page', to: 'about_pages#show', as: 'about_page'
      resources :categories
      resources :subcategories
      resources :contacts, only: [:create]
      resources :shopping_carts, only: [:index, :show] do
        collection do
          patch :add_order_items
          patch :add_address
          patch :place_order
          patch :cancele_order
          get :apply_promo
          get :remove_promo
          get :show_current
          get :setting
        end
        member do
          delete :order_item_destroy
        end
      end
      resources :banners, only: [:index]
      resources :divisions, only: [:index]
      resources :promotions, only: [:index]
      resources :trade_offers, only: [:index]
      resources :addresses
      resources :item_masters do
        collection do
          get :search
          get :search_item_master
        end
      end
      resources :brands, only: [:index]
      resources :wallets do
        collection do
          get :show_user_wallet
        end
      end
      resources :epg_payments do
        post :registration, :make_payment, :get_payment_details, :epg_payment_response, on: :collection
      end
    end
  end

  namespace :api, as: nil, defaults: { format: 'xml' } do
    namespace :xml, as: nil do
      namespace :v1, as: nil do
        namespace :users do
          # wash_out :registration
          # wash_out :sessions
          # wash_out :users
          # wash_out :confirmations
          # wash_out :password_resets

          #    post :social_media_login,  to: 'sessions#social_media_login', as: 'social_media_login'
          post 'authenticate',  to: 'sessions#create'#, as: 'login'
          post 'sign_up',       to: 'registration#create'#, as: 'sign_up'
          post 'password_resets', to: 'password_resets#create'#, as: 'password_resets'
          get 'password_resets/:token/edit', to: 'password_resets#edit'#, as: 'edit_password_resets'
          put 'password_resets/:token', to: 'password_resets#update'#, as: 'update_password_resets'
          get 'confirmations/:token', to: 'confirmations#show'#, as: 'confirmations'
          get 'account_profile', to: 'users#account_profile'
          patch 'update_password', to: 'users#update_password'
          patch 'update_profile', to: 'users#update_profile'
          resources :users do
            collection do
              get :notification
            end
          end
        end
        # wash_out :banners
        # wash_out :about_pages
        # wash_out :categories
        # wash_out :brands
        # wash_out :divisions
        # wash_out :products
        # wash_out :subcategories
        # wash_out :wallets

        wash_out :trade_offer_products
        wash_out :trade_offers
        wash_out :promotions
        wash_out :item_masters
        wash_out :shopping_carts
        wash_out :open_invoices
        wash_out :customer_price_lists
        wash_out :customer_masters
        wash_out :addresses
        wash_out :order_items
        # wash_out :saleorder_statuses

        resources :products do
          collection do
            get :search
          end
        end

        get 'about_page', to: 'about_pages#show'#, as: 'about_page'
        resources :categories
        resources :subcategories
        resources :shopping_carts, only: [:index, :show] do
          collection do
            patch :add_order_items
            patch :add_address
            patch :place_order
            patch :cancele_order
            get :apply_promo
            get :show_current
          end
        end
        resources :banners, only: [:index]
        resources :divisions, only: [:index]
        resources :promotions, only: [:create, :index]
        resources :trade_offers, only: [:create, :index]
        resources :item_masters
        resources :open_invoices, only: [:create, :index]
        resources :customer_price_lists, only: [:create, :index]
        resources :brands, only: [:index]
        resources :saleorder_statuses, only: [:update]
        resources :customer_masters, only: [:create] do
          collection do
            patch :update_customer_master
          end
        end
        resources :wallets do
          collection do
            get :show_user_wallet
          end
        end
      end
    end
  end
end
