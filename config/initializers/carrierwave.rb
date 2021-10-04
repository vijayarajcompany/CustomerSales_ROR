CarrierWave.configure do |config|
  config.fog_public = false
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    endpoint:         'https://sgp1.digitaloceanspaces.com',
    provider:              'AWS',
    aws_access_key_id:     'C7GCE62L2FLHF7KDMAQ4',
    aws_secret_access_key: 'VGJ+HIA35GoEaKagcPGJ5MogIpg1O76FJl2uoAldtk8',
    region:                'sgp1',
  }
  config.fog_directory  =  'pepsidrc'
  config.asset_host = 'https://pepsidrc.sgp1.digitaloceanspaces.com'
end