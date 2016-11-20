# == Schema Information
#
# Table name: space_pictures
#
#  id         :integer          not null, primary key
#  image      :string
#  primary    :boolean          default(FALSE)
#  space_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SpacePicture < ActiveRecord::Base
  mount_uploader :image, SpacePictures::ImageUploader

  belongs_to :space
end
