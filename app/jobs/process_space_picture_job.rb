class ProcessSpacePictureJob < ActiveJob::Base
  queue_as :default

  def perform(space_picture_id)
    picture = SpacePicture.find(space_picture_id)
    picture.remote_image_url = picture.temp_image_url
    picture.temp_image_url = nil
    picture.temp_image_s3_key = nil
    picture.save!
  end
end
