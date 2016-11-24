# == Schema Information
#
# Table name: coupons
#
#  id          :integer          not null, primary key
#  coupon_type :integer
#  discount    :decimal(15, 2)   default(0.0)
#  code        :string
#  plan_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Coupon < ActiveRecord::Base
  belongs_to :plan
  has_many :subscriptions

  enum coupon_type: [:discount_percentage, :discount_value]

  validates :coupon_type, presence: true
  validates :discount, presence: true, numericality: {greater_than: 0}
  validates :code, presence: true

  after_initialize :assign_code, if: -> { new_record? && code.blank? }

  scope :for_all_plans, -> { where(plan_id: nil) }

  def valid_for_plan?(plan)
    plan_id.nil? || plan_id == plan.id
  end

  private

    def assign_code
      loop do
        self.code = SecureRandom.hex(4).upcase
        break unless Coupon.exists?(code: self.code)
      end
    end
end
