WIN_COMBINATIONS = [
    [0,1,2], # Top
    [3,4,5], # Middle
    [6,7,8], # Bottom
    [0,3,6], # Left
    [1,4,7], # Middle
    [2,5,8], # Right
    [0,4,8], # back diagonal
    [2,4,6] # forward diagonal
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  else
    false
  end
end

def valid_move?(board, index)
  if index.between?(0,8) == true && position_taken?(board, index) == false
    true
  else
    false
  end
end

def get_input
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
end

def turn(board)
  index = get_input

  if valid_move?(board, index) == false
    index = get_input
  end
  
  move(board, index, current_player(board))
  display_board(board)
 end
 
def turn_count(board)
  count = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      count += 1
    end
  end
  count  
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.detect do |combination|
      board.values_at(combination[0],combination[1],combination[2]) == ['X', 'X', 'X'] || board.values_at(combination[0],combination[1],combination[2]) == ['O', 'O', 'O'] 
    end
end

def full?(board)
  not board.detect{|position| position == " "}
end

def draw?(board)
  if (not !!won?(board)) && !!full?(board) 
    true
  end
end

 def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

 def winner(board)
  if !!won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end