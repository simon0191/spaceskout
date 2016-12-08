# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  confirmation_token       :string
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  type                     :string
#  business_name            :string
#  first_name               :string
#  last_name                :string
#  phone                    :string
#  avatar                   :string
#  accepts_terms_of_service :boolean
#

class User < ActiveRecord::Base
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         password_length: 8..128

  mount_uploader :avatar, SpaceOwners::AvatarUploader

  has_many :spaces
  has_many :subscriptions

  validates :password, format: {with: /\A[\w]*\d[\w]*\Z/, message: 'must contain at least 1 number'}, if: -> { password.present? }

  def has_access_level?(role)
    [:customer].include?(role.to_sym)
  end

  def has_reviewed_space?(space)
    space.reviews.where(user_id: self.id).count > 0
  end

  def available_posts
    subscriptions.not_expired.sum(:available_publications)
  end

  def full_name
    [first_name, last_name].reject(&:blank?).map(&:capitalize).join(' ')
  end

  # Mailboxer methods
  def mailboxer_email(object)
    email
  end

  def mailboxer_name
    full_name
  end
end
