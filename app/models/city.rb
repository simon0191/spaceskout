# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  active     :boolean          default(FALSE)
#  state_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base
  belongs_to :state
  has_many :spaces

  scope :active, -> { joins(:state).where(active: true, 'states.active': true) }
  scope :available, -> { active.joins(:spaces).uniq }
end
