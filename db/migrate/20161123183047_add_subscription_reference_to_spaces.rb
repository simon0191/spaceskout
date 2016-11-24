class AddSubscriptionReferenceToSpaces < ActiveRecord::Migration
  def change
    add_reference :spaces, :subscription, index: true, foreign_key: true
  end
end
