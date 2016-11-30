required_keys = [
  'STRIPE_PUBLIC_KEY',
  'STRIPE_SECRET_KEY',
  'FILE_STORAGE',
]
if ENV['FILE_STORAGE'] == 'fog'
  required_keys += [
    'AWS_ACCESS_KEY_ID',
    'AWS_SECRET_ACCESS_KEY',
    'AWS_REGION',
    'AWS_S3_BUCKET'
  ]
end

if Rails.env.production?
  required_keys += [
    'EMAIL_AUTHENTICATION',
    'EMAIL_ENABLE_STARTTLS_AUTO',
    'EMAIL_SMTP_ADDRESS',
    'EMAIL_SMTP_PORT',
    'SENDGRID_PASSWORD',
    'SENDGRID_USERNAME',
    'SS_HOST',

    'NEW_RELIC_LICENSE_KEY',
  ]
end

Figaro.require_keys(*required_keys)