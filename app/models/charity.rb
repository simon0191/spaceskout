# == Schema Information
#
# Table name: charities
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  logo        :string
#  featured    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Charity < ActiveRecord::Base
  mount_uploader :logo, Charities::LogoUploader

  scope :featured, -> { where(featured: true) }
end
