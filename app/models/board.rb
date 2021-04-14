class Board < ApplicationRecord
    has_many :mines

    # name & email must exist
    validates :name, :email, presence: true

    # board name must be unique
    validates :name, uniqueness: true

    # h & w are positive integers
    validates :height, :width, :numericality => { :greater_than_or_equal_to => 0 }

end