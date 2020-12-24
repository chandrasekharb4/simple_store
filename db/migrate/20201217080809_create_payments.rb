class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :mobile_number
      t.float :amount
      t.string :tnr_no
      t.string :payment_status
      t.text :transaction_details
      t.string :payment_at
      t.string :email
      t.string :name
      t.string :used_file_no
      t.boolean :is_used, default:false

      t.timestamps
    end
  end
end
