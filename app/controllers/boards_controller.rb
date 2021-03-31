class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end
    
    def create
        @newBoard = Board.new(board_params)

        if @newBoard.save

            redirect_to @newBoard
        else
            flash[:error] = @newBoard.errors.full_messages.to_sentence
            redirect_to '/'
        end
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