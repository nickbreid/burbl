class AddValidationsToStop < ActiveRecord::Migration[5.1]
  def up
    change_column_null :stops, :name, false
    change_column_null :stops, :miles_from_ga, false
    change_column_null :stops, :miles_from_k, false
    remove_column :stops, :to_next_point
    add_index :stops, :miles_from_k, unique: true
  end

  def down
    change_column_null :stops, :name, true
    change_column_null :stops, :miles_from_ga, true
    change_column_null :stops, :miles_from_k, true

    add_column :stops, :to_next_point, :float
    remove_index :stops, :miles_from_k
  end
end
