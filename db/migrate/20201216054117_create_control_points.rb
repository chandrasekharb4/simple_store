class CreateControlPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :control_points do |t|
      t.string :name
      t.string :location
      t.string :district
      t.string :contact_number
      t.string :email
      t.boolean :active, default:true
      t.string :code
      t.string :image

      t.timestamps
    end
  end
end
