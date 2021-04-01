class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end
    
    def create
        # destructure params
        height, width, mines, email, name = board_params.values_at(:height, :width, :mines, :email, :name)

        # pass numbers to mondel method to generate 2d array board format
        dimensions = Board.generate_board(height.to_i, width.to_i, mines.to_i)

        puts dimensions

        # create instance
        if dimensions 
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
        else
            flash[:error] = "Dimensions invalid. Height & width must be positive integers; mines cannot exceed available board spaces."
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