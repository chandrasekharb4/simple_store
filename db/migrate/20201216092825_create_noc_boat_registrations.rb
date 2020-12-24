class CreateNocBoatRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :noc_boat_registrations do |t|
      t.string :owner_name
      t.string :agency_name
      t.string :owner_email
      t.string :mobile_number
      t.text :adress
      t.string :boat_name
      t.string :boat_type
      t.string :engine_type
      t.string :manufacturing_certificate_number
      t.string :manufacturing_date
      t.string :proposed_location
      t.string :proposed_use
      t.string :file_no
      t.integer :user_id
      t.string :application_status
      t.date :applied_date
      t.date :expire_date
      t.date :approved_date
      t.string :paid_amount
      t.string :tnr_no
      t.string :aadharCard
      t.string :manufacturing_certificate
      t.integer :approved_by
      t.text :comment
      t.integer :controll_room_id

      t.timestamps
    end
  end
end
