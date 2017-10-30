class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :name
      t.text :description
      t.float :miles_from_ga
      t.integer :elevation
      t.float :distance_from_trail

      t.timestamps
    end
    add_index :stops, :miles_from_ga, unique: true
  end
end
