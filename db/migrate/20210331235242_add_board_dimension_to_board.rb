class AddBoardDimensionToBoard < ActiveRecord::Migration[6.1]
  def change
    add_column :boards, :dimensions, :string, array: true, default: []
  end
end
