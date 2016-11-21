class Charities::LogoUploader < CarrierWave::Uploader::Base

  storage ENV['FILE_STORAGE'].try(:to_sym) || :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
