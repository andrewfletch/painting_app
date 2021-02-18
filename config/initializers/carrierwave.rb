CarrierWave.configure do |config|
  config.storage    =  :aws                  # required
  config.aws_bucket =  Rails.application.credentials.aws[:s3_bucket]      # required
  config.aws_acl    =  :public_read

  config.aws_credentials = {
    access_key_id:      Rails.application.credentials.aws[:s3_access_key],       # required
    secret_access_key:  Rails.application.credentials.aws[:s3_secret_key],     # required
    region: 'us-west-2'
  }
end