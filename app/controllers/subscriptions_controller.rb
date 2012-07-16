class SubscriptionsController < ApplicationController
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
  end
  
  # def edit
    # @subscription = current_user.subscriptions.find(params[:id]) if current_user
  # end
#   
  # def update
    # if current_user
      # @subscription = current_user.subscriptions.find(params[:id])
      # if @subscription.update_with_payment("Auth token: "+current_user.auth_token+"; Company Email: "+current_user.email+"; Company Name: "+current_user.full_name)
        # redirect_to @subscription, :notice => "Card info successfully updated!"
      # else
        # render :edit
      # end
    # else
      # redirect_to log_in_path, :error => "You must login first!"
    # end
  # end

  def create
    if current_user
      @subscription = Subscription.new(params[:subscription])
      if @subscription.save_with_payment(current_user, "Auth token: "+current_user.auth_token+"; Company Email: "+current_user.email+"; Company Name: "+current_user.full_name)
        current_user.subscriptions.push(@subscription)
        redirect_to @subscription, :notice => "Thank you for subscribing!"
      else
        render :new
      end
    else
      redirect_to log_in_path, :error => "You must login first!"
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    smb = Smb.find(params[:smb_id])
    subscription = plan.subscriptions.build
    redirect_to subscription.paypal.checkout_url(
      :return_url => new_subscription_url(:plan_id => plan.id, :smb_id => smb.id),
      :cancel_url => root_url
    )
  end
end
