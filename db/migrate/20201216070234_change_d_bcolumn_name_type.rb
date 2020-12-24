class ChangeDBcolumnNameType < ActiveRecord::Migration[6.0]
  def change
  		change_column :proposed_uses, :active, :boolean
  end
end
