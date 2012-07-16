class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :smb
  validates_presence_of :plan_id
  
  attr_accessor :stripe_card_token, :paypal_payment_token
  
  def save_with_payment(user, description)
    if valid?
      if paypal_payment_token.present?
        save_with_paypal_payment
      else
        save_with_stripe_payment(user, description)
      end
    end
  end
  
  def paypal
    PaypalPayment.new(self)
  end
  
  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end

  def save_with_stripe_payment(user, description)
    if user.card_provided?
      customer = Stripe::Customer.retrieve(user.stripe_customer_token)
      customer.update_subscription(:plan => plan_id)
      #TODO maybe do some check here with customer( response from stripe server ) if success, then set status and status in current_user
    else
      if user.stripe_customer_token.present?
        customer = Stripe::Customer.retrieve(user.stripe_customer_token)
        customer.card = stripe_card_token
        customer.save
      else
        customer = Stripe::Customer.create(:description => description, :email => user.email_for_card, :plan => plan_id, :card => stripe_card_token)
        user.stripe_customer_token = customer.id
      end
      user.card_on_file = true
      user.save!
    end
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer/updating plan: #{e.message}"
    errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  end
  
  def payment_provided?
    stripe_card_token.present? || paypal_payment_token.present?
  end
  

end
