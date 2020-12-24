class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile_no
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.string :password
      t.string :password_confirmation
      t.boolean :super_admin
      t.boolean :employee
      t.boolean :employee_code
      t.string :user_role
      t.integer :control_room_id
      t.boolean :unit_user, default:false
      t.boolean :ho_user, default:false
      t.boolean :admin, default:false

      t.timestamps
    end
  end
end
