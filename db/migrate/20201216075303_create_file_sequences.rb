class CreateFileSequences < ActiveRecord::Migration[6.0]
  def change
    create_table :file_sequences do |t|
      t.string :file_type
      t.integer :sequence_no

      t.timestamps
    end
  end
end
