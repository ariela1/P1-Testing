# frozen_string_literal: true

require_relative './observer/observable'

# Modelo del tablero
class Board < Observable
  attr_accessor :mode, :first_matrix_j1, :second_matrix_j1, :first_matrix_j2, :second_matrix_j2, :difficulty

  def initialize
    super()
    @first_matrix_j1 = []
    @second_matrix_j1 = []
    @first_matrix_j2 = []
    @second_matrix_j2 = []
    @mode = 0
    @difficulty = 0
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
  end

  def set_difficulty_hard
    hard_board =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*']]
    @first_matrix_j1 = hard_board.map(&:clone)
    @second_matrix_j1 = hard_board.map(&:clone)
    @first_matrix_j2 = hard_board.map(&:clone)
    @second_matrix_j2 = hard_board.map(&:clone)
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
end
