class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name
      t.string :code
      t.integer :division_id
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
