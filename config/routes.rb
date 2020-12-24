Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	resources :boats do
		get :boatActive, :on => :collection
		get :boatInActive, :on => :collection
		get :boatClearance, :on => :collection
		post :updateBoatClearance, :on => :collection
		get :display_trip_details, :on => :collection
		get :display_trip_details1, :on => :collection
		get :trip_end, :on => :collection
		get :generateclearance, :on => :collection
	end
  	resources :boat_drivers
	resources :boat_types
	resources :control_points
	resources :divisions
	resources :engine_types
	resources :file_sequences

 	resources :noc_boat_registrations do
	    get :pay_noc_payment, :on => :collection
	    post :checkOut, :on => :collection
	    post :pay_zippy_response, :on => :collection
	    get :pending_noc_boat_registrations, :on => :collection
	    get :approved_noc_boat_registrations, :on => :collection
	    get :rejected_noc_boat_registrations, :on => :collection
	    get :accept_noc, :on => :collection
	    get :reject_noc, :on => :collection
	    get :generateNoce, :on => :collection
	    get :noc_registrations, :on => :collection
	    get :per_orders, :on => :collection
  	end

  	resources :payments
  	resources :permission_orders do
	    get :pending_orders, :on => :collection
	    get :approved_orders, :on => :collection
	    get :rejected_orders, :on => :collection
	    get :accept_orders, :on => :collection
	    get :reject_orders, :on => :collection
  	end

	resources :proposed_uses
	resources :system_settings
	resources :trip_clearances
	 resources :trip_drivers
	resources :user_roles
	resources :users do
		get :homePage, :on => :collection
		get :contactUs, :on => :collection
		get :employee_list, :on => :collection
		get :create_employee, :on => :collection
		post :update_employee, :on => :collection
		get :create_admin, :on => :collection
		post :update_admin, :on => :collection

		get :unit_dashboard, :on => :collection
		get :user_dashBoard, :on => :collection
		get :ho_dashBoard, :on => :collection
		get :ho_dashBoard1, :on => :collection
	end

	resources :units

	resources :user_sessions do
    get :new, :on => :collection
  end

  get "cc_avenue/dataFrom"

  get "cc_avenue/ccavRequestHandler"

  post "cc_avenue/ccavResponseHandler"

  get 'logout', :controller => 'user_sessions', :action => 'destroy'
  get 'login', :controller => 'user_sessions', :action => 'new'

   root :to => 'users#homePage'

end
