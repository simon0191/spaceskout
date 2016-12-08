class AddDocumentToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :document, :string
  end
end
