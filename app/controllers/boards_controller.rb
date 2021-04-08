class BoardsController < ApplicationController
    def index
        # pluck will do a select of the values wanted, instead of loading whole model in
        @emails = Board.pluck(:email).uniq
        
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
                # use render :new so it populates the form with the board data that was sent through on first attempt -- on the frontend it looks like it "didn't delete" the form data. kind of awkward with h/w/m right now because those are not a part of the model, so they don't populate correctly through this render :new
                flash[:error] = @board.errors.full_messages.to_sentence        
                @most_recent_boards = Board.last(10).reverse
                @board      
                render :new
            end
        else
            # not best practice to have a catch-all flash message. will be changed once the models are updated
            flash[:error] = "Dimensions invalid. Height & width must be positive integers that do not exceed 718 and 262 respectively; mines cannot exceed available board spaces."
            @most_recent_boards = Board.last(10).reverse
            @board
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