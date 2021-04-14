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
        
        # create board instance
        @board = Board.new({
            name:name, 
            email:email, 
            height:height,
            width:width,
        })

        if @board.save

            # if the board's valid, create mine instances by passing numbers to model method to generate 2d array board format
            mines = Mine.generate_mine_values(height.to_i, width.to_i, mines.to_i)

            # persist each one to DB
            mines.each do |name, coords|
                Mine.create({**coords, "board_id"=>@board.id})
            end

            redirect_to @board
        else
            # if board's not valid, use render :new so it populates the form with the board data that was sent through on first attempt
            flash[:error] = @board.errors.full_messages.to_sentence        
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
        board_selected = Board.find(params[:id])
        @board = BoardSerializer.new(board_selected)
    end

    private
    def board_params
        params.require(:board).permit(:name, :email, :width, :height, :mines)
    end
end