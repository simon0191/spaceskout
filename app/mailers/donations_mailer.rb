class DonationsMailer < ApplicationMailer

  def thank_you(donation)
    @donation = donation
    @user = donation.user
    mail to: donation.donor_email, subject: 'Thank you for your donation!'
  end
end
