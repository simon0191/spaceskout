class AddTempImageS3KeyToSpacePictures < ActiveRecord::Migration
  def change
    add_column :space_pictures, :temp_image_s3_key, :string
  end
end
