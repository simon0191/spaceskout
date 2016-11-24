# == Schema Information
#
# Table name: plans
#
#  id                     :integer          not null, primary key
#  name                   :string
#  number_of_publications :integer
#  price                  :decimal(15, 2)   default(0.0)
#  duration_in_days       :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  additional_info        :text
#

class Plan < ActiveRecord::Base
  has_many :subscriptions
  has_many :coupons

  validates :name, presence: true
  validates :number_of_publications, presence: true, numericality: {greater_than: 0}
  validates :price, presence: true, numericality: {greater_than: 0.0}
  validates :duration_in_days, presence: true, numericality: {greater_than: 0}
end
