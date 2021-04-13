class Mine < ApplicationRecord
  belongs_to :board

  def self.generate_mine_values(height, width, mine_count)
    # this method should return a 2d array of objs representing "the state of the board before the game starts"

    # create record of selected mine locations
    mine_locations = {}

    mine_count.times do
        # grab random coordinates
        randomX = rand(1..width)
        randomY = rand(1..height)

        # if these coords have already been picked, pick again
        while (mine_locations["X#{randomX}Y#{randomY}"]) do
            randomX = rand(1..width)
            randomY = rand(1..height)
        end

        # once we get fresh ones, add them to the record
        mine_locations["X#{randomX}Y#{randomY}"] = {"x": randomX, "y": randomY}

    end

    mine_locations
  end
end
