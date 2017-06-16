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
#  phone_number               :string
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
#  phone                      :boolean          default(FALSE)
#  kitchen                    :boolean          default(FALSE)
#  outside_catering_allowed   :boolean          default(FALSE)
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
#  subscription_id            :integer
#  document                   :string
#  inhouse_catering           :boolean          default(FALSE)
#

class Space < ActiveRecord::Base
  mount_uploader :document, Spaces::DocumentUploader

  belongs_to :city
  belongs_to :user
  alias_method :owner, :user
  belongs_to :subscription

  has_many :categories, through: :space_categories
  has_many :reviews, dependent: :destroy
  has_many :space_categories, dependent: :destroy
  has_many :space_pictures, dependent: :destroy

  accepts_nested_attributes_for :space_pictures, allow_destroy: true

  enum capacity: [:less_50, :between_50_100, :between_100_200, :between_200_500, :between_500_1000, :more_1000]
  enum classification: [:restaurant, :meeting_room, :hotel, :conference_center, :outdoor, :gallery, :studio, :museum, :theater]

  validates :classification, presence: true
  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :phone_number, presence: true
  validates :capacity, presence: true
  validates :price_hourly, presence: true
  validates :price_daily, presence: true
  validates :price_buyout, presence: true
  validates :description, presence: true

  validate :validate_at_leat_1_category
  validate :validate_at_least_1_amenities
  validate :validate_at_least_1_day
  validate :validate_phone_number_10_or_11_digits
  validate :validate_at_least_3_pictures

  scope :published, -> { joins(:subscription).where('subscriptions.valid_through > ?', DateTime.now) }

  def self.amenities
    @amenities ||= [:wifi, :audio_visual, :projector, :white_board, :table_chair, :parking, :phone, :kitchen, :outside_catering_allowed, :inhouse_catering]
  end

  def self.days
    @days ||= week_days + weekend_days
  end

  def self.week_days
    @weekdays ||=  [:monday, :tuesday, :wednesday, :thursday, :friday]
  end

  def self.weekend_days
    @weekend_days ||=  [:saturday, :sunday]
  end

  def update_rating!
    self.update_column(:rating, reviews.average(:rating) || 0)
  end

  def full_address
    [address1, address2].reject(&:blank?).map(&:capitalize).join(', ')
  end

  def published?
    subscription && subscription.not_expired?
  end

  def main_picture
    space_pictures.main.first.try(:image) || space_pictures.first.try(:image)
  end

  def address
    [address1, address2].reject(&:blank?).join(', ')
  end

  def formatted_availabilities
    result = {}
    if weekdays_availability_from.present?
      self.class.week_days.reduce(result) do |r, day|
        if self.send("#{day}?")
          r[day.capitalize] = "#{num_to_hour(weekdays_availability_from)} - #{num_to_hour(weekdays_availability_to)}"
        end
        r
      end
    end
    if weekend_availability_from.present?
      self.class.weekend_days.reduce(result) do |r, day|
        if self.send("#{day}?")
          r[day.capitalize] = "#{num_to_hour(weekend_availability_from)} - #{num_to_hour(weekend_availability_to)}"
        end
        r
      end
    end
    result
  end

  def website_url
    case website
    when /\Ahttp(s?):\/\/.*\Z/
      website
    else
      "http://#{website}"
    end

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

    def num_to_hour(n)
      date = DateTime.current.beginning_of_day
      "#{date.change(hour: n).strftime('%l:00 %p')}"
    end

    def validate_phone_number_10_or_11_digits
      if phone_number.present? && phone_number.gsub(/\D/,'').length != 10 && phone_number.gsub(/\D/,'').length != 11
        errors[:phone_number] << 'should have 10 or 11 digits (includes area code)'
      end
    end

    def validate_at_least_3_pictures
      if space_pictures.reject(&:marked_for_destruction?).length < 3
        errors.add :space_pictures, 'upload at least 3 pictures'
      end
    end

end
