class CreateHikers < ActiveRecord::Migration[5.1]
  def change
    create_table :hikers do |t|
      t.string :name, null: false
      t.float :miles_from_end, null: false
      t.boolean :nobo, default: true

      t.timestamps
    end
  end
end
