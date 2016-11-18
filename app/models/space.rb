# == Schema Information
#
# Table name: spaces
#
#  id                        :integer          not null, primary key
#  name                      :string
#  classification            :integer
#  address1                  :string
#  address2                  :string
#  zip_code                  :string
#  phone                     :string
#  capacity                  :integer
#  rating                    :decimal(15, 2)   default(0.0)
#  published                 :boolean          default(FALSE)
#  published_until           :datetime
#  special_note              :text
#  organization_description  :text
#  space_description         :text
#  website                   :string
#  price_hour                :integer
#  price_daily               :integer
#  price_buyout              :integer
#  wifi                      :boolean          default(FALSE)
#  audio_visual              :boolean          default(FALSE)
#  projector                 :boolean          default(FALSE)
#  white_board               :boolean          default(FALSE)
#  table_chair               :boolean          default(FALSE)
#  parking                   :boolean          default(FALSE)
#  phone_number              :boolean          default(FALSE)
#  kitchen                   :boolean          default(FALSE)
#  catering                  :boolean          default(FALSE)
#  weekdays_avaiability_from :integer
#  weekdays_avaiability_to   :integer
#  weekend_avaiability_from  :integer
#  weekend_avaiability_to    :integer
#  minimum_number_of_hours   :integer
#  monday                    :boolean          default(FALSE)
#  tuesday                   :boolean          default(FALSE)
#  wednesday                 :boolean          default(FALSE)
#  thursday                  :boolean          default(FALSE)
#  friday                    :boolean          default(FALSE)
#  saturday                  :boolean          default(FALSE)
#  sunday                    :boolean          default(FALSE)
#  user_id                   :integer
#  city_id                   :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Space < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  has_many :space_categories
  has_many :categories, through: :space_categories

  enum capacity: [:less_50, :between_50_100, :between_100_200, :between_200_500, :between_500_1000, :more_1000]
  enum classification: [:restaurant, :meeting_room, :hotel, :conference_center, :outdoor, :gallery, :studio, :museum, :theater]
end
