if ENV['FILE_STORAGE'] == 'fog'
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION']
    }
    config.fog_directory  = ENV['AWS_S3_BUCKET']
    config.fog_public     = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
end