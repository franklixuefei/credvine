# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120708201521) do

  create_table "assignments", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_catagories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "camp_name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "smb_id"
    t.date     "exp_date"
    t.text     "term_and_conditions"
    t.text     "final_thx"
    t.text     "init_thx"
    t.text     "thx_frien"
    t.boolean  "make_cust_incentive_a_surprise"
    t.boolean  "give_frien",                     :default => true
    t.boolean  "give_cust_success",              :default => true
    t.boolean  "give_cust_ref_sent",             :default => true
    t.integer  "incentive_type_csi_id"
    t.integer  "incentive_type_id"
    t.text     "cust_sent_incentive"
    t.text     "cust_successful_incentive"
    t.decimal  "incentive_val"
    t.decimal  "incentive_val_csi"
    t.text     "cust_sent_incentive_long"
    t.text     "cust_successful_incentive_long"
    t.text     "term_of_use"
    t.text     "term_of_use_csi"
    t.boolean  "status",                         :default => true
    t.text     "frien_welc_header"
    t.boolean  "notify_me_per_succ_ref"
    t.boolean  "temp",                           :default => true
    t.string   "init_thx_greeting"
    t.string   "final_thx_greeting"
    t.string   "thx_frien_greeting"
    t.string   "frien_welc_header_greeting"
    t.string   "init_thx_subject"
    t.string   "final_thx_subject"
    t.string   "friend_welc_header_subject"
    t.string   "thx_frien_subject"
  end

  create_table "code_pointers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "identifier"
    t.integer  "iid"
  end

  create_table "codes", :force => true do |t|
    t.string   "cust_init_code"
    t.string   "frien_code"
    t.string   "cust_init_status",    :default => "SENT"
    t.string   "frien_status",        :default => "NOT_SENT"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "smb_partial"
    t.string   "cust_partial"
    t.string   "frien_partial"
    t.string   "cust_success_code"
    t.string   "cust_success_status", :default => "NOT_SENT"
    t.integer  "smb_id"
    t.integer  "customer_id"
    t.integer  "friend_id"
    t.integer  "campaign_id"
    t.integer  "incentive_id"
    t.boolean  "paid"
    t.text     "temp_final_thx"
    t.string   "identifier"
    t.integer  "code_pointer_id"
  end

  create_table "countries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "customer_codes", :force => true do |t|
    t.string   "c_code"
    t.boolean  "redeemed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "fullname"
    t.string   "phone"
    t.string   "email"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "partial_code"
    t.text     "frien_welc"
    t.string   "auth_token"
    t.integer  "cust_init_coupon_request_times",    :default => 0
    t.integer  "cust_init_coupon_redemption_times", :default => 0
    t.datetime "cust_init_sent_at",                 :default => '2012-03-07 15:52:47'
    t.string   "avatar_url"
  end

  create_table "customers_friends", :id => false, :force => true do |t|
    t.integer  "customer_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers_smbs", :id => false, :force => true do |t|
    t.integer  "customer_id"
    t.integer  "smb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_path"
    t.integer  "smb_id"
  end

  create_table "fields", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_codes", :force => true do |t|
    t.string   "f_code"
    t.boolean  "redeemed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", :force => true do |t|
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.string   "partial_code"
  end

  create_table "friends_smbs", :id => false, :force => true do |t|
    t.integer  "friend_id"
    t.integer  "smb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incentive_type_csis", :force => true do |t|
    t.string   "type_of_incentive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type_of_incentive_exp"
  end

  create_table "incentive_type_fis", :force => true do |t|
    t.string   "type_of_incentive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type_of_incentive_exp"
  end

  create_table "incentive_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type_of_incentive"
    t.string   "type_of_incentive_exp"
  end

  create_table "incentives", :force => true do |t|
    t.text     "frien_incentive",      :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
    t.integer  "incentive_type_fi_id"
    t.decimal  "incentive_val_fi"
    t.text     "frien_incentive_long"
    t.text     "term_of_use_fi"
  end

  create_table "jobs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "period"
  end

  create_table "promo_codes", :force => true do |t|
    t.string   "promo_code"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "smb_id"
    t.string   "promo_credit"
    t.integer  "signup_request_id"
  end

  create_table "reports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "smb_id"
  end

  create_table "signup_requests", :force => true do |t|
    t.string   "request_email"
    t.string   "package_type"
    t.string   "beta_key"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "smbs", :force => true do |t|
    t.string   "full_name"
    t.string   "abbr_name"
    t.string   "industry"
    t.string   "st_name_num"
    t.integer  "suite_num"
    t.string   "city"
    t.string   "zip_pos"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "partial_code"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "username"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "email"
    t.integer  "business_catagory_id"
    t.string   "state_prov"
    t.boolean  "per_success",                 :default => true
    t.string   "auth_token"
    t.string   "stripe_customer_token"
    t.string   "email_for_card"
    t.boolean  "card_on_file",                :default => false
    t.date     "date_of_payment_for_ref"
    t.boolean  "campaign_activated"
    t.integer  "num_of_codes_to_pay",         :default => 0
    t.integer  "num_of_succ_codes_to_pay"
    t.boolean  "admin"
    t.boolean  "activated"
    t.boolean  "first_time",                  :default => true
    t.boolean  "profile_completed"
    t.boolean  "campaign_confirmed"
    t.string   "activation_token"
    t.boolean  "campaign_launched"
    t.string   "featured_photo_file_name"
    t.string   "featured_photo_content_type"
    t.integer  "featured_photo_file_size"
    t.datetime "featured_photo_updated_at"
    t.string   "site_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "yelp_url"
    t.string   "linkedin_url"
    t.string   "business_description"
    t.string   "business_type"
    t.string   "credit"
    t.integer  "temp_credit",                 :default => 0
    t.string   "PIN"
    t.boolean  "campaign_created"
    t.boolean  "insert_map",                  :default => true
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "smbs_friends", :id => false, :force => true do |t|
    t.integer  "smb_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "country_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "smb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_token"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.integer  "plan_id"
    t.string   "status"
  end

  create_table "temp_table_for_custs", :force => true do |t|
    t.string   "fullname"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_file_id"
  end

  create_table "temptexts", :force => true do |t|
    t.text     "cust_init"
    t.text     "cust_success"
    t.text     "frien_welc_ref"
    t.text     "frien_post_redemp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "header_message"
  end

end
