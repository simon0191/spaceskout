# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(FALSE)
#  description :string
#

class Category < ActiveRecord::Base
  has_many :space_categories
  has_many :spaces, through: :space_categories

  scope :active, -> { where(active: true) }
end
