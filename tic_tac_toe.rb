class TicTacToe
	attr_accessor :player1, :player2, :board

  @@last_player = nil

	def initialize
		
    puts "Please write player1 name"
    player1_name = gets.chomp
    player1_choice = "X"
    puts "Please write player2 name"
    player2_name = gets.chomp
    player2_choice = "O"
    
		@player1 = Player.new(player1_name, player1_choice)
		@player2 = Player.new(player2_name, player2_choice)
    @board = Board.new

		puts "Player1 is #{player1_name} and will be #{player1_choice}, Player2 is #{player2_name} and will be #{player2_choice}"
	end

  def start
    puts "Welcome to Tic Tac Toe!, \n\n This is the board, start the game by placing an X or an O in the board according to number position"
    display_board
    while game_over? == false
      turn
      display_board
    end    
  end

  def turn

    if @@last_player == nil || @@last_player == @player2
      @@last_player = @player1
    else
        @@last_player = @player2
    end

    puts "Please #{@@last_player.name} select your move from 1 to 9"
    board_move = gets.chomp.to_i
    while move_used?(board_move) == true
      puts "Please #{@@last_player.name} select your move from 1 to 9"
      board_move = gets.chomp.to_i
    end
      move(board_move, @@last_player.player_choice)
  end

  def move(board_move, player_choice)
    puts "you move to #{board_move} and place an #{player_choice}"
    
    @board.positions.each do | position, value |
      if board_move == value
        board.positions[position] = player_choice
      end
    end 

  end

  def display_board
    puts board.positions[:up_left].to_s + " | " + board.positions[:up_center].to_s + " | " + board.positions[:up_right].to_s
    puts board.positions[:center_left].to_s + " | " + board.positions[:center_center].to_s + " | " + board.positions[:center_right].to_s
    puts board.positions[:down_left].to_s + " | " + board.positions[:down_center].to_s + " | " + board.positions[:down_right].to_s
  end

  def game_over?

    if victory?
      puts "GAME OVER"
      return true      
    elsif nobody_win?
      puts "GAME OVER, NOBODY WINS :( "
      return true
    else
      return false
    end
  end

  def victory?

    if @@last_player != nil

      if  board.positions[:up_left] == board.positions[:up_center] && board.positions[:up_center] == board.positions[:up_right]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:center_left] == board.positions[:center_center] && board.positions[:center_center] == board.positions[:center_right]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:down_left] == board.positions[:down_center] && board.positions[:down_right] == board.positions[:down_center]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:up_left] == board.positions[:center_left] && board.positions[:down_left] == board.positions[:center_left]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:up_center] == board.positions[:center_center] && board.positions[:down_center] == board.positions[:center_center]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:up_right] == board.positions[:center_right] && board.positions[:down_right] == board.positions[:center_right] 
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:up_left] == board.positions[:center_center] && board.positions[:down_right] == board.positions[:center_center]
        puts "#{@@last_player.name} WINS!!"
        return true
      elsif board.positions[:up_right] == board.positions[:center_center] && board.positions[:down_left] == board.positions[:center_center] 
        puts "#{@@last_player.name} WINS!!"
        return true 
      else
        return false 
      end
    end
  end

  def nobody_win?

     check = board.positions.all? {|k,v| v.is_a? String }
      if check
        puts "nobody win"
        return true
      else 
        return false
      end
  end

  def move_used?(board_move)
    if board.positions.has_value?(board_move) == false
      puts "That move was already used"
      return true
    else
      return false
    end
  end

  class Player
    attr_accessor :name, :player_choice
    
    def initialize(name, player_choice)
      @name = name
      @player_choice = player_choice
    end
  end

  class Board
    attr_accessor :positions
    
    def initialize
      @positions = { up_left: 1, up_center: 2, up_right: 3, center_left: 4, center_center: 5,  center_right: 6, down_left: 7, down_center: 8, down_right: 9 }
    end
  end


end

my_game = TicTacToe.new
my_game.start
