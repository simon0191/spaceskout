if ENV['SIDEKIQ_INLINE'].present?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end
