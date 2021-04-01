class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end
    
    def create
        # destructure params
        height, width, mines, email, name = board_params.values_at(:height, :width, :mines, :email, :name)

        # generate 2d array board format
        dimensions = Board.generate_board(height, width, mines)
        
        # create instance
        @board = Board.new({
            name:name, 
            email:email, 
            dimensions: dimensions
        })

        if @board.save
            redirect_to @board
        else
            flash[:error] = @board.errors.full_messages.to_sentence
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
        params.require(:board).permit(:name, :email, :width, :height,:mines)
      end
end