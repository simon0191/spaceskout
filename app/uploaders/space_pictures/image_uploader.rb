class SpacePictures::ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage ENV['FILE_STORAGE'].try(:to_sym) || :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.image_path('fallback/space_pictures/' + [version_name, 'default.png'].compact.join('_'))
  end

  version :thumb do
    process resize_and_pad: [80, 80]
  end

  version :croped do
    process resize_and_pad: [760, 390]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
