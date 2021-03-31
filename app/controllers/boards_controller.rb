class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end

    def show
        @board = Boar.dfind(params[:id])
    end

    # should add strong params
end