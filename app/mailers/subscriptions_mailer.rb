class SubscriptionsMailer < ApplicationMailer

  def purchase_confirmation(subscription)
    @subscription = subscription
    @user = subscription.user
    mail to: @user.email, subject: 'Purchase Confirmation'
  end
end
