# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  type                   :string
#  business_name          :string
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  avatar                 :string
#

class SpaceOwner < User

  validates :business_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :avatar, presence: true

  validate :validate_phone_10_digits

  def has_access_level?(role)
    [:customer, :space_owner].include?(role.to_sym)
  end

  private

    def validate_phone_10_digits
      if phone.present? && phone.gsub(/\D/,'').length != 10
        errors[:phone] << 'should have 10 digits (includes area code)'
      end
    end
end
