ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)

  map.resources :members
  
  map.resources :elements

  map.resources :sidepics

  map.resources :projects

  map.resources :galleries

  map.resources :pictures

  map.resources :posts do |post|
    post.resources :elements, :as => 'content'
  end
  
  map.news 'news', :controller => 'posts', :action => 'index'
  map.news 'news/:id', :controller => 'posts', :action => 'show'
  
  map.schedule 'schedule', :controller => 'pages', :action => 'schedule'
  map.profile 'profile', :controller => 'pages', :action => 'profile'
  map.imprint 'imprint', :controller => 'pages', :action => 'imprint'
  map.contact 'contact', :controller => 'pages', :action => 'contact'
  map.directions 'directions', :controller => 'pages', :action => 'directions'
  map.archive 'archive', :controller => 'pages', :action => 'archive'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "posts"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
