required_keys = [
  'STRIPE_PUBLIC_KEY',
  'STRIPE_SECRET_KEY',
  'FILE_STORAGE',
]
if ENV['FILE_STORAGE'] == 'fog'
  required_keys += [
    'AWS_ACCESS_KEY',
    'AWS_ACCESS_SECRET',
    'AWS_REGION',
    'AWS_S3_BUCKET'
  ]
end

Figaro.require_keys(*required_keys)