class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :control_room_id
      t.string :name_of_the_vessel
      t.string :registration_number
      t.string :owner_of_the_vessel
      t.string :owner_email
      t.string :mobile_no
      t.string :navigation_route
      t.string :route_permission_number
      t.string :captain_name
      t.string :captain_license_no
      t.integer :created_by
      t.string :user_id
      t.integer :life_jackets
      t.integer :fire_extinguishers
      t.integer :passenger_capacity
      t.integer :life_rafts
      t.integer :life_buoys
      t.string :trip_duriation
      t.string :boat_type
      t.string :engine_type
      t.string :proposed_use
      t.boolean :active, default:true
      t.string :permission_file_no
      t.string :status
      t.boolean :trip_run, default:false
      t.integer :division_id
      t.integer :unit_id

      t.timestamps
    end
  end
end
