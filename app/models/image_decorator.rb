Spree::Image.class_eval do
  if Rails.env.production?
    if ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY'] && ENV['AWS_BUCKET']
      S3_OPTIONS = {
        :storage => 's3',
        :s3_credentials => {
          :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
          :bucket => ENV['AWS_BUCKET']
        },
        :s3_protocol => 'https'
      }
    else
      S3_OPTIONS = {
        :storage => 's3',
        :s3_credentials => Rails.root.join('config', 's3.yml')
      }
    end
  else
    S3_OPTIONS = { :storage => 'filesystem' }
  end

  attachment_definitions[:attachment] = (attachment_definitions[:attachment] || {}).merge(S3_OPTIONS)
end