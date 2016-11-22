# == Schema Information
#
# Table name: spaces
#
#  id                         :integer          not null, primary key
#  name                       :string
#  classification             :integer
#  address1                   :string
#  address2                   :string
#  zip_code                   :string
#  phone                      :string
#  capacity                   :integer
#  rating                     :decimal(15, 2)   default(0.0)
#  published                  :boolean          default(FALSE)
#  published_until            :datetime
#  special_note               :text
#  organization_description   :text
#  description                :text
#  website                    :string
#  price_hourly               :integer
#  price_daily                :integer
#  price_buyout               :integer
#  wifi                       :boolean          default(FALSE)
#  audio_visual               :boolean          default(FALSE)
#  projector                  :boolean          default(FALSE)
#  white_board                :boolean          default(FALSE)
#  table_chair                :boolean          default(FALSE)
#  parking                    :boolean          default(FALSE)
#  phone_number               :boolean          default(FALSE)
#  kitchen                    :boolean          default(FALSE)
#  catering                   :boolean          default(FALSE)
#  weekdays_availability_from :integer
#  weekdays_availability_to   :integer
#  weekend_availability_from  :integer
#  weekend_availability_to    :integer
#  minimum_number_of_hours    :integer
#  monday                     :boolean          default(FALSE)
#  tuesday                    :boolean          default(FALSE)
#  wednesday                  :boolean          default(FALSE)
#  thursday                   :boolean          default(FALSE)
#  friday                     :boolean          default(FALSE)
#  saturday                   :boolean          default(FALSE)
#  sunday                     :boolean          default(FALSE)
#  user_id                    :integer
#  city_id                    :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Space < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  has_many :categories, through: :space_categories
  has_many :ratings
  has_many :space_categories
  has_many :space_pictures, dependent: :destroy

  accepts_nested_attributes_for :space_pictures, allow_destroy: true

  enum capacity: [:less_50, :between_50_100, :between_100_200, :between_200_500, :between_500_1000, :more_1000]
  enum classification: [:restaurant, :meeting_room, :hotel, :conference_center, :outdoor, :gallery, :studio, :museum, :theater]

  validates :classification, presence: true
  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :phone, presence: true
  validates :capacity, presence: true
  validates :price_hourly, presence: true
  validates :price_daily, presence: true
  validates :price_buyout, presence: true
  validates :minimum_number_of_hours, presence: true
  validates :description, presence: true
  validates :space_pictures, length: {minimum: 3, message: "upload at least 3 pictures"}

  validate :validate_at_leat_1_category
  validate :validate_at_least_1_amenities
  validate :validate_at_least_1_day

  def self.amenities
    @amenities ||= [:wifi, :audio_visual, :projector, :white_board, :table_chair, :parking, :phone_number, :kitchen, :catering]
  end

  def self.days
    @days ||= [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  end

  def main_picture
    space_pictures.first.try(:image)
  end

  def address
    [address1, address2].reject(&:blank?).join(', ')
  end

  private

    def validate_at_least_1_amenities
      unless self.class.amenities.any? { |amenity| send("#{amenity}?") }
        errors.add(:amenities, 'select at least one Amenity')
      end
    end

    def validate_at_least_1_day
      unless self.class.days.any? { |day| send("#{day}?") }
        errors.add(:availability, 'select at least one Day')
      end
    end

    def validate_at_leat_1_category
      unless categories.any?
        errors.add(:categories, 'select at least one Category')
      end
    end

end
