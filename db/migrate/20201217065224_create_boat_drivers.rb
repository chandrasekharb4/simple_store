class CreateBoatDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :boat_drivers do |t|
      t.integer :boat_id
      t.string :name
      t.string :license_numner

      t.timestamps
    end
  end
end
