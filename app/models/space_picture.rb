# == Schema Information
#
# Table name: space_pictures
#
#  id                :integer          not null, primary key
#  image             :string
#  primary           :boolean          default(FALSE)
#  space_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  temp_image_url    :string
#  temp_image_s3_key :string
#

class SpacePicture < ActiveRecord::Base
  mount_uploader :image, SpacePictures::ImageUploader

  belongs_to :space
  after_create :process_image

  validates :temp_image_url, presence: true, on: :create
  validates :temp_image_s3_key, presence: true, on: :create

  scope :main, -> { where(primary: true) }

  private

    def process_image
      ProcessSpacePictureJob.perform_later(self.id)
    end

end
