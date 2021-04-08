class Board < ApplicationRecord
    has_many :mines

    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    # add validation here to make sure the h & w is a positive integer and that mines do not exceed h*w

    def self.generate_mine_values(height, width, mines)
        # this method should return a 2d array of objs representing "the state of the board before the game starts"

        # create outer array
        mines = []

        # add correct number of inner arrays (rows) with correct number of elements (cols)
        height.times do 
            mines.push(Array.new(width, false))
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
            mines[row][col] = true
        end

        mines
    end


end