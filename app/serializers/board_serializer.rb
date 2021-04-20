class BoardSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :height, :width, :hashed_mines

    # the frontend view needs a simple way of checking and placing mines
    def hashed_mines
        mine_hash = {}

        object.mines.each do |mine|
            mine_hash["X#{mine[:x]}Y#{mine[:y]}"] = true
        end

        mine_hash
    end
end
  