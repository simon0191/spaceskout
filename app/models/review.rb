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
  validates :user, presence: true
  validates :space, presence: true

  after_create :update_space_rating

  private

    def update_space_rating
      space.update_rating!
    end
end
