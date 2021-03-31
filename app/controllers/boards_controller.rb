class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end
    
    def create
        @newBoard = Board.new(board_params)
        if @newBoard.save

            redirect_to @newBoard
        else
            # add errors info to flash
        end
        # this should actually redirect to show but leaving as index for now
        # fallback, re-render same page
        # render :new
    end

    def new
        @board = Board.new
    end

    def show
        @board = Board.find(params[:id])
    end

    private
    def board_params
        params.require(:board).permit(:name, :email, :height, :width, :mines)
      end
end