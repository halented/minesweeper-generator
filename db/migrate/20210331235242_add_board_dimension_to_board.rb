class AddBoardDimensionToBoard < ActiveRecord::Migration[6.1]
  def change
    add_column :boards, :height, :integer
    add_column :boards, :width, :integer
  end
end
