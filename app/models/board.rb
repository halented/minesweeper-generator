class Board < ApplicationRecord
    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    def self.generate_board(h, w, m)
        [
            [true, false, false],
            [false, true, false],
            [false, true, false]
        ]
    end

end