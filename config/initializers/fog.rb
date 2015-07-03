CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],                        # required
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],                        # required
    region:                'us-west-1'                  # optional, defaults to 'us-east-1'
    #host:                  's3.amazon.com',             # optional, defaults to nil
    #endpoint:              's3-website-us-west-1.amazonaws.com' # optional, defaults to nil
  }

  config.fog_directory  = 'elsuperbucket'                          # required
  #config.fog_public     = false                                        # optional, defaults to true
  #config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}

#Access Key Id,Secret Access Key
end