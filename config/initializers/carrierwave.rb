CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV["access_key_id"],       
    :aws_secret_access_key  => ENV["secret_key"]
    # :region                 => 'Tokyo'  # your bucket's region in S3, defaults to 'us-east-1'
  }
  # your S3 bucket name
  config.fog_directory  = 'tinydenny'
  # custome your domain on aws S3, defaults to nil
  # config.fog_host       = 'http://myapp.com'
  config.fog_public     = true                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end