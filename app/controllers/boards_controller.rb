class BoardsController < ApplicationController
    def index
        # pluck will do a select of the values wanted, instead of loading whole model in
        @emails = Board.all.pluck do |b| b.email end.uniq

        if params[:email]
            @boards = Board.all.filter do |b| b.email === params[:email] end
        else
            @boards = Board.all
        end
    end
    
    def create
        # destructure params
        height, width, mines, email, name = board_params.values_at(:height, :width, :mines, :email, :name)

        # pass numbers to mondel method to generate 2d array board format
        dimensions = Board.generate_board(height.to_i, width.to_i, mines.to_i)
        
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
                # using render :new so we dont lose form data
                flash[:error] = @board.errors.full_messages.to_sentence
                render :new
            end
        else
            # not best practice to have a catch-all flash message
            flash[:error] = "Dimensions invalid. Height & width must be positive integers that do not exceed 718 and 262 respectively; mines cannot exceed available board spaces."
            render :new
        end
    end

    def new
        @most_recent_boards = Board.last(10).reverse
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