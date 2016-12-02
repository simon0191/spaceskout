# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  text       :string
#  user_id    :integer
#  space_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :rating, presence: true
  validates :user, presence: true, uniqueness: {scope: :space_id}
  validates :space, presence: true

  validate :validate_user_is_not_owner

  after_create :update_space_rating

  private

    def update_space_rating
      space.update_rating!
    end

    def validate_user_is_not_owner
      if user.present? && space.present? && user == space.owner
        errrors[:user] << "can't be the owner of the space"
      end
    end
end
