class ProcessSpacePictureJob < ActiveJob::Base
  queue_as :default

  def perform(space_picture_id)
    s3_object = S3_BUCKET.object(picture.temp_image_s3_key)

    picture = SpacePicture.find(space_picture_id)
    picture.remote_image_url = picture.temp_image_url
    picture.temp_image_url = nil
    picture.temp_image_s3_key = nil
    picture.save!

    s3_object.delete
  end
end
