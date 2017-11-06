class AddsPhotoUrlToStop < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :photo_url, :string
  end
end
