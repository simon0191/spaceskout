# == Schema Information
#
# Table name: space_categories
#
#  id          :integer          not null, primary key
#  category_id :integer
#  space_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SpaceCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :space
end
