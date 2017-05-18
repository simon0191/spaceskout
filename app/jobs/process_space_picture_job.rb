class ProcessSpacePictureJob < ActiveJob::Base
  include ActiveJob::Retry.new(
    strategy: :constant,
    limit: 3,
    delay: 1.minute,
    retryable_exceptions: [
      ActiveRecord::RecordInvalid, # May be caused by a Net::ReadTimeout
      ActiveRecord::RecordNotFound
    ]
  )

  queue_as :default

  rescue_from(StandardError) { |error| logger.fatal error }

  def perform(space_picture_id)
    logger.info "Processing space_picture-#{space_picture_id} START"
    picture = SpacePicture.find(space_picture_id)
    if picture.temp_image_s3_key.present?
      picture.remote_image_url = S3_BUCKET.object(picture.temp_image_s3_key).public_url
      picture.temp_image_url = nil
      picture.temp_image_s3_key = nil
      picture.save!
      logger.info "Processing space_picture-#{space_picture_id} DONE"
    else
      logger.info "Processing space_picture-#{space_picture_id}, temp_image_s3_key NOT PRESENT"
    end
  end
end
