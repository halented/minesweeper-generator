class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :height
      t.integer :width
      t.integer :mines
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
