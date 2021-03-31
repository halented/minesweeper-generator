class Board < ApplicationRecord
    # all attributes must exist
    validates :name, :email, :height, :width, :mines, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    # board values cannot be negative, 0, or a float
    validates :height, :width, :mines, numericality: {only_integer: true, greater_than_or_equal_to: 1}

end