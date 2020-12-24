class CreateTripClearances < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_clearances do |t|
      t.integer :boat_id
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
      t.string :created_by
      t.integer :life_jackets
      t.integer :fire_extinguishers
      t.integer :passenger_capacity
      t.integer :life_rafts
      t.integer :life_buoys
      t.integer :trip_duriation
      t.string :boat_type
      t.string :engine_type
      t.string :proposed_use
      t.boolean :is_current, default:false
      t.date :departure_date
      t.boolean :wearing_life_jackets, default:false
      t.boolean :influence_of_alcohol, default:false
      t.boolean :trip_end, default:false
      t.string :trip_no
      t.datetime :start_time
      t.datetime :end_time
      t.text :remarks
      t.integer :passenger_count
      t.string :briefed_to_passenger
      t.string :overloaded
      t.string :wearing_life_jackets_all
      t.string :influence_of_alcohol_all
      t.string :registered_with_aptdc
      t.string :has_route_permissions
      t.string :has_prominently_displays_the_capacity
      t.string :has_lifesaving_equipment
      t.string :has_adequate_firefighting_equipment
      t.string :does_not_have_any_major_damage
      t.string :has_crew_displayed
      t.string :driver_has_the_requisite_license_and_is_registered
      t.string :crew_have_the_requisite_licenses_and_are_registered
      t.string :boat_driver_and_the_crew_have_their_identity_cards_badges
      t.string :crew_is_fit_and_healthy_not

      t.timestamps
    end
  end
end
