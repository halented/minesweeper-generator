class Board < ApplicationRecord
    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    def self.generate_board(height, width, mines)

        # can't have more mines than spaces, h&w must be more than 0
        if mines > height * width
            return false
        elsif height <= 0 || width <= 0
            return false
        end

        # create outer array
        dimensions = []

        # add correct number of inner arrays (rows) with correct number of elements (cols)
        height.times do 
            dimensions.push(Array.new(width, false))
        end

        # randomly place mines by pretending that it's a 1d array
        # & selecting a random index
        length = height * width
        previously_selected_indicies = {}

        mines.times do
            randomIndex = rand(0..length-1)

            # make sure we haven't selected it before
            while previously_selected_indicies[randomIndex]
                randomIndex = rand(0..length-1)
            end

            # add it into the list so we won't select it again
            previously_selected_indicies[randomIndex] = true

            # do some math to put the mine into the matrix
            # row = selectedIndex/cols rounded down
            # col = selected%cols
            row = (randomIndex/width).floor
            col = randomIndex%width
            dimensions[row][col] = true
        end

        dimensions
    end

end