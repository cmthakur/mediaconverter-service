CarrierWave.configure do |config|
  config.storage = :s3
  config.s3_access_key_id = '05X6SXDVXV8EMGD8B8G2'
  config.s3_secret_access_key = 'caQD1f8OYQwCKWw+kxRyZv+iqNKIeiqn4GhUqmxp'
  # config.s3_bucket = 'robot-bucket'
  # config.s3_access = :public_read
end

class MediaUploader < CarrierWave::Uploader::Base
  # include CarrierWave::MiniMagick
  if settings.environment == :production
    storage :s3
  else
    storage :file
  end

  def store_dir
    "converter_service/converted"
  end

  def s3_headers
    { "Expires" => (Time.now + 6000).httpdate }
  end

  def self.s3_bucket
    'media-robot'
  end

  def extensions_white_list
    %w(mov mp3 mp4 flv mpeg)
  end
end
