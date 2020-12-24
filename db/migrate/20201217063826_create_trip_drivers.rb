class CreateTripDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_drivers do |t|
      t.string :name
      t.string :license_number
      t.integer :boat_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
