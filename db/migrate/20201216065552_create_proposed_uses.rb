class CreateProposedUses < ActiveRecord::Migration[6.0]
  def change
    create_table :proposed_uses do |t|
      t.string :name
      t.string :code
      t.string :active,default:true

      t.timestamps
    end
  end

  def change
  	change_column :proposed_uses, :active, :boolean

  end
end
