# frozen_string_literal: true

# Modelo del tablero
class Board
  attr_accessor :mode,
                :first_matrix_j1,
                :second_matrix_j1,
                :first_matrix_j2,
                :second_matrix_j2, 
                :difficulty,
                :j1_attack,
                :j2_attack


  def initialize
    super()
    @first_matrix_j1 = []
    @second_matrix_j1 = []
    @first_matrix_j2 = []
    @second_matrix_j2 = []
    @mode = 0
    @difficulty = 0
    @ships = 0
    @j1_attack = 0
    @j2_attack = 0
  end

  def set_difficulty_easy
    easy_board =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*']]
    @first_matrix_j1 = easy_board.map(&:clone)
    @second_matrix_j1 = easy_board.map(&:clone)
    @first_matrix_j2 = easy_board.map(&:clone)
    @second_matrix_j2 = easy_board.map(&:clone)
    @difficulty = 1
    @ships = 17
  end

  def set_difficulty_hard
    hard_board =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*',
        '*', '*', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
        '_', '_', '*'],
       ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*',
        '*', '*', '*']]
    @first_matrix_j1 = hard_board.map(&:clone)
    @second_matrix_j1 = hard_board.map(&:clone)
    @first_matrix_j2 = hard_board.map(&:clone)
    @second_matrix_j2 = hard_board.map(&:clone)
    @difficulty = 2
    @ships = 28
  end

  def rows
    if @difficulty == 1
      10
    else
      15
    end
  end

  def place_vertical_ship(xpos, ypos, y_fin, player)
    (ypos..y_fin).each do |posicion|
      if posicion == ypos
        mark(posicion, xpos, ' i ', player, 1)
      elsif posicion == y_fin
        mark(posicion, xpos, ' f ', player, 1)
      else
        mark(posicion, xpos, ' m ', player, 1)
      end
    end
  end

  def place_horizontal_ship(xpos, ypos, x_fin, player)
    (xpos..x_fin).each do |posicion|
      if posicion == xpos
        mark(ypos, posicion, ' i ', player, 1)
      elsif posicion == x_fin
        mark(ypos, posicion, ' f ', player, 1)
      else
        mark(ypos, posicion, ' m ', player, 1)
      end
    end
  end

  def mark(xo_pos, yo_pos, symbol, player, type)
    # marcar simbolo en la coordenada especificada
    if player == 1
      if type == 1
        @first_matrix_j1[xo_pos][yo_pos] = symbol
      else
        @second_matrix_j1[xo_pos][yo_pos] = symbol
      end
    elsif type == 1
      @first_matrix_j2[xo_pos][yo_pos] = symbol
    else
      @second_matrix_j2[xo_pos][yo_pos] = symbol
    end
  end

  def symbol_at(xo_pos, yo_pos, player, type)
    if player == 1
      if type == 1
        @first_matrix_j1[xo_pos][yo_pos]
      else
        @second_matrix_j1[xo_pos][yo_pos]
      end
    elsif type == 1
      @first_matrix_j2[xo_pos][yo_pos]
    else
      @second_matrix_j2[xo_pos][yo_pos]
    end
  end

  def add_attack_on_boards(player, x, y)
    if player == 1
      case @first_matrix_j2[x][y]
      when ' i '
        @second_matrix_j1[x][y] = ' x '
        @first_matrix_j2[x][y] = ' I '
        @j1_attack += 1
      when ' m '
        @first_matrix_j2[x][y] = ' M '
        @second_matrix_j1[x][y] = ' x '
        @j1_attack += 1
      when ' f '
        @first_matrix_j2[x][y] = ' F '
        @second_matrix_j1[x][y] = ' x '
        @j1_attack += 1
      else
        @first_matrix_j2[x][y] = ' - '
        @second_matrix_j1[x][y] = ' - '
      end
    else
      case @first_matrix_j1[x][y]
      when ' i '
        @second_matrix_j2[x][y] = ' x '
        @first_matrix_j1[x][y] = ' I '
        @j2_attack += 1
      when ' m '
        @second_matrix_j2[x][y] = ' x '
        @first_matrix_j1[x][y] = ' M '
        @j2_attack += 1
      when ' f '
        @second_matrix_j2[x][y] = ' x '
        @first_matrix_j1[x][y] = ' F '
        @j2_attack += 1
      else
        @first_matrix_j1[x][y] = ' - '
        @second_matrix_j2[x][y] = ' - '
      end
    end
  end

  def winner
    if @j1_attack == @ships
      return true
    elsif @j2_attack == @ships
      return true
    else
      return false
    end
  end
end
