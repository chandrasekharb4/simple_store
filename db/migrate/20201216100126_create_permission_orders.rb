class CreatePermissionOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_orders do |t|
      t.string :control_room_location
      t.string :name_of_the_vessel
      t.string :registration_number
      t.string :owner_of_the_vessel
      t.string :owner_email
      t.string :mobile_no
      t.string :navigation_route
      t.string :route_permission_number
      t.string :license_registration_certificate
      t.string :routes_permisiion
      t.string :captain_license
      t.string :noc_certificate
      t.string :captain_name
      t.string :captain_license_no
      t.string :application_status
      t.date :appllied_date
      t.integer :approved_by
      t.date :approved_at
      t.string :approved_document
      t.integer :user_id
      t.string :file_no
      t.integer :life_jackets
      t.integer :fire_extinguishers
      t.integer :passenger_capacity
      t.integer :life_rafts
      t.integer :controll_room_id

      t.timestamps
    end
  end
end
