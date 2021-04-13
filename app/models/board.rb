class Board < ApplicationRecord
    has_many :mines

    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    # add validation here to make sure the h & w is a positive integer and that mines do not exceed h*w

end