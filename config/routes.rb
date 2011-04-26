Friendap::Application.routes.draw do

  resources :invitation_sents

  match '/api/testuser' => 'api#testuser'
  match '/api/login' => 'api#login'
  match '/api/current_user_prayers' => 'api#current_user_prayers'
  match '/api/selected_user_prayers' => 'api#selected_user_prayers'
  match '/api/prayers' => 'api#prayers'
  match '/api/create_prayer' => 'api#create_prayer'
  match '/api/get_friend_list' => 'api#get_friend_list'
  match '/api/get_all_users' => 'api#get_all_users'
  match '/api/get_all_users' => 'api#get_all_users'
  match '/api/delete_prayer' => 'api#delete_prayer'
  match '/api/create_user' => 'api#create_user'
  match '/api/friend_request' => 'api#friend_request'
  match '/api/rejected_friends' => 'api#rejected_friends'
  match '/api/get_invitation_pending' => 'api#get_invitation_pending'
  match '/api/accept_invitation' => 'api#accept_invitation'
  match '/api/reject_invitation' => 'api#reject_invitation'
  match '/api/get_prayer_comments' => 'api#get_prayer_comments'
  match '/api/add_prayer_viewed' => 'api#add_prayer_viewed'
  match '/api/add_prayer_prayed' => 'api#add_prayer_prayed'
  match '/api/add_comment' => 'api#add_comment'
  match '/api/logout' => 'api#logout'
  match '/api/get_current_user_profile' => 'api#get_current_user_profile'
  match '/api/change_password' => 'api#change_password'
  
  match '/users/edit_image' => 'users#edit_image'
  match '/users/update_image' => 'users#update_image'
  match '/users/change_password' => 'users#change_password'
  resources :api
  resources :prayers
  resources :comments
  match '/homes' => 'users#user_action'
  resources :reject_friends
  resources :homes
  resources :facebooktests
  match '/join_the_network/:id' => 'friend_requests#join_the_network'
  match '/users/code_image/:id' => 'users#code_image'
  match '/users/show_profile/:id' => 'users#show_profile'
  match '/reset/:reset_code' => 'users#reset'
  match '/users/forgot' => 'users#forgot'
  match '/users/update_password' => 'users#update_password'
  match '/users/edit_profile' => 'users#edit_profile'
  match '/users/update_profile' => 'users#update_profile'
  match '/users/koalatest' => 'users#koalatest'
  match '/friend_requests/friend_request' => 'friend_requests#friend_request'
  match '/friend_requests/send_friend_request' => 'friend_requests#send_friend_request'
  resources :friend_requests
  match '/friendships/invite_friend' => 'friendships#invite_friend'
  match '/friendships/pending_invitation' => 'friendships#pending_invitation'
  match '/friendships/accept_invitation' => 'friendships#accept_invitation'
  match '/friendships/reject_invitation' => 'friendships#reject_invitation'
  match '/friendships/invitation_by' => 'friendships#invitation_by'
  match '/friendships/invite' => 'friendships#invite'
  match '/friendships/invitation' => 'friendships#invitation'
  match '/friendships/get_all_friend' => 'friendships#get_all_friend'
  match '/users/my_profile' => 'users#my_profile'
  resources :friendships
  resources :users
  resource :session, :only => [:new, :create, :destroy]
  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil
  
  match "/post_on_wall" => "users#post_on_wall"
  root :to => "users#user_action"
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
