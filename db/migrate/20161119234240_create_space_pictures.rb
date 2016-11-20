class CreateSpacePictures < ActiveRecord::Migration
  def change
    create_table :space_pictures do |t|
      t.string :image
      t.boolean :primary, default: false
      t.references :space, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
