class Board < ApplicationRecord
    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    def self.generate_board(height, width, mines)

        # make sure the input would actually make a board
        if !Board.dimension_validator(height, width, mines)
            return false
        end

        # create outer array
        dimensions = []

        # add correct number of inner arrays (rows) with correct number of elements (cols)
        height.times do 
            dimensions.push(Array.new(width, false))
        end

        # randomly place mines
        # create array to track potential mine spaces
        length = height * width - 1
        available_indicies = [*0..length]

        mines.times do
            # grab a random space from the available ones
            randomIndex = rand(0..available_indicies.length-1)

            # remove space from available list
            available_indicies = available_indicies - [randomIndex]

            # do some math to put the mine back into the 2d matrix
            # row = selectedIndex/cols rounded down
            # col = selected%cols
            row = (randomIndex/width).floor
            col = randomIndex%width
            dimensions[row][col] = true
        end

        dimensions
    end

    def self.dimension_validator(height, width, mines)
        # if there are more mines than spaces, if the h or w is negative or larger than world record, report error to user
        # records for largest board is 718 x 262
        # originally had this as 1k x 1k but one million squares seemed like...a lot
        if mines >= height * width || mines <= 0
            return false
        elsif height <= 0 || width <= 0 || height > 718 || width > 262
            return false
        end
        return true
    end

end