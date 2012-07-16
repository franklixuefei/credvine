ReferralHook::Application.routes.draw do


  get "plans/index"
  get 'paypal/checkout', :to => 'subscriptions#paypal_checkout'
  
  #post 'webhooks/actions' do
    # retrieve the request's body and parse it as JSON
    #event_json = JSON.parse(request.body.read)
  
    # for extra security
    #event = Stripe::Event.retrieve(event_json['id'])
  
    # do something with event

  #end
  resources :password_resets do
    post 'send_instruction', :on => :collection
  end
  resources :subscriptions

  # get "smbs/redemption"

  # get "campaigns/edit_status"
# 
  # get "campaign/edit_status"

  resources :temptexts

  resources :incentives

  resources :welcome do
    get 'hiw', :on => :collection
    get 'pricing', :on => :collection
    get 'contact', :on => :collection
    post 'invite', :on => :collection
    get 'terms', :on => :collection
    get 'about', :on => :collection
    get 'privacypolicy', :on => :collection
    get 'faqs', :on => :collection
    get 'books_resources', :on => :collection
    post 'contact_send', :on => :collection
  end

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "smbs#new", :as => "sign_up"

  resources :sessions
  
  match "/auth/:provider/callback" => "custsessions#create"
  match "/signout" => "custsessions#destroy", :as => :signout
  match "/how_it_works" => "welcome#hiw", :as => :how_it_works
  match "/pricing" => "welcome#pricing", :as => :pricing
  match "/contact" => "welcome#contact", :as => :contact
  match "/invite" => "welcome#invite", :as => :invite
  match "/contact_send" => "welcome#contact_send", :as => :contact_send
  match "/terms" => "welcome#terms", :as => :terms
  match "/about" => "welcome#about", :as => :about
  match "/privacypolicy" => "welcome#privacypolicy", :as => :privacypolicy
  match "/faqs" => "welcome#faqs", :as => :faqs
  match "/books_resources" => "welcome#books_resources", :as => :books_resources
  
  


  resources :temp_table_for_custs

  get "reports/index"
  
  resources :codes
  
post '/ajax/del_camp/:id' => 'campaigns#destroy'

  resources :smbs do
    resources :customers do
      resources :friends do
        get 'error', :on => :collection
        get 'confirmed', :on => :member
      end
      post 'uploadFile', :on => :collection
      get 'review', :on => :collection
      post 'confirm', :on => :collection
      get 'send_message', :on => :member
      get 'referral_sent', :on => :member
    end
     
    resources :campaigns do
      resources :incentives
      get 'edit_status', :on => :collection
      post 'update_status', :on => :collection
      post 'autosave', :on => :member
      get 'autosave_create', :on => :collection
      get 'confirm_campaign', :on => :member
      get 'campaign_launched', :on => :member
      get 'campaign_preview', :on => :member
     
    end
    resources :friends
    resources :reports
    get 'redemption', :on => :member
    post 'redeem', :on => :member
    get 'coupon', :on => :member
    #get 'subscription', :on => :member
    get 'cardinfo', :on => :member
    post 'savecard', :on => :member
    get 'editcard', :on => :member
    post 'updatecard', :on => :member
    get 'deletecard', :on => :member
    get 'error_page', :on => :member
    #get 'activate_campaign', :on => :member
    get 'edit_thx_msg_to_succ_cust', :on => :member
    get 'send_thx_msg', :on => :member
    get 'custom_thx_sent', :on => :member
    get 'navigation', :on => :member
    get 'closer', :on => :member
    get 'closer_last', :on => :member
    get 'close_window', :on => :member
    #get 'done', :on => :member
    get 'activate_account', :on => :member
    get 'check_on_file', :on => :member
    post 'check_if_username_taken', :on => :collection
    post 'check_if_email_taken', :on => :collection
    get 'dashboard', :on => :member
    get 'gen_coupon', :on => :collection
    get 'thanks', :on => :collection
    get 'admin_dashboard', :on => :member
    post 'approve', :on => :collection
    post 'ignore', :on => :collection
    # post 'check_beta_key', :on => :collection
    # post 'check_promo_code', :on => :collection
    post 'check_all', :on => :collection
    get 'poster', :on => :member
    get 'referral_card', :on => :member
    post 'fetch_request', :on => :collection
    post 'fetch_smb_user_data', :on => :collection
    get 'gen_promocode', :on => :collection
    post 'add_promocode', :on => :collection
    post 'del_promocode', :on => :collection
    post 'set_admin', :on => :collection
    post 'set_payment', :on => :collection
    post 'del_smb', :on => :collection
    get 'redeem_mobile', :on => :collection
    post 'redeeming_mobile', :on => :member
    get 'post_mobile_redemption', :on => :collection
    post 'change_pin', :on => :member
    post 'resend_send', :on => :collection
    post 'pull_email_text', :on => :collection
    post 'check_old_password', :on => :collection
    post 'change_password', :on => :collection
    post 'del_pic', :on => :member
  end
    
  resources :customers do
    resources :friends
    resources :smbs
  end


  resources :friends do
    resources :customers
    resources :smbs
  end
    
  resources :campaigns do
    resources :incentives
    get 'campaign_preview', :on => :member
  end

  resources :incentives
  
  resources :sessions


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match "/thanks" => "smbs#thanks"
  match "/voucher_redeemed" => "smbs#post_mobile_redemption"
  match "/:username/:id/sent" => "customers#referral_sent"
  match "/:username" => "customers#new" # :username will be passed to controller as a params. So in controller we can 
                                          # recognize this param by calling params[:username]
  match "/redeem/:scanned_code" => "smbs#redeem_mobile"
  
  
   root :to => 'welcome#index'
  match ':controller(/:action(/:id(.:format)))'
   
end
