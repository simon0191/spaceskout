class Spaces::PublishForm < BaseForm
  attr_accessor :user, :space

  validates :user, presence: true
  validates :space, presence: true

  validate :validate_space_unpublished
  validate :validate_user_has_available_posts

  def save!
    subscription = user.subscriptions.not_expired.with_available_posts.order(:valid_through).take
    begin
      ActiveRecord::Base.transaction do
        subscription.available_publications -= 1
        subscription.save!
        space.subscription = subscription
        space.save!
      end
      true
    rescue ActiveRecord::RecordInvalid => invalid
      invalid.record.errors.full_messages.each{ |e| errors[invalid.record.class.name.underscore] << e }
      false
    end
  end

  private

    def validate_space_unpublished
      if space && space.published?
        errors[:space] << 'already published'
      end
    end

    def validate_user_has_available_posts
      if user.available_posts <= 0
        errors[:user] << "doesn't have available posts"
      end
    end
end