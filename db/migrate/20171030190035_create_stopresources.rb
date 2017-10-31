class CreateStopresources < ActiveRecord::Migration[5.1]
  def change
    create_table :stopresources do |t|
      t.belongs_to :stop, foreign_key: true
      t.belongs_to :resource, foreign_key: true
      t.float :distance_from_trail
      t.string :direction_from_trail
      t.string :stop_name

      t.timestamps
    end
  end
end
