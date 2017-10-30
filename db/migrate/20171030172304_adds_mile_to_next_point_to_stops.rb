class AddsMileToNextPointToStops < ActiveRecord::Migration[5.1]
  def up
    add_column :stops, :to_next_point, :float
    add_column :stops, :town_access, :string
    add_column :stops, :miles_from_k, :float
    remove_column :stops, :distance_from_trail
  end

  def down
    remove_column :stops, :to_next_point, :float
    remove_column :stops, :town_access, :string
    remove_column :stops, :miles_from_k, :float
    add_column :stops, :distance_from_trail, :float
  end
end
