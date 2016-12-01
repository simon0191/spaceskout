class AddTempImageUrlToSpacePictures < ActiveRecord::Migration
  def change
    add_column :space_pictures, :temp_image_url, :string
  end
end
