class CreateBoatTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :boat_types do |t|
      t.string :name
      t.string :code
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
