# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

# Revisa inicialización del tablero en modo fácil o difícil
class InitBoard < Test::Unit::TestCase
  def setup
    @easy_board =
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
    @hard_board =
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
  end

  def test_board_dif_easy
    @board = Board.new
    @board.set_difficulty_easy
    # Ver si se actualizan todos los atributos del modelo
    assert_equal(@board.first_matrix_j1, @easy_board)
    assert_equal(@board.first_matrix_j2, @easy_board)
    assert_equal(@board.second_matrix_j1, @easy_board)
    assert_equal(@board.second_matrix_j2, @easy_board)
    assert_equal(@board.difficulty, 1)
    assert_equal(@board.rows, 10)
  end

  def test_board_dif_hard
    @board = Board.new
    @board.set_difficulty_hard
    # Ver si se actualizan todos los atributos del modelo
    assert_equal(@board.first_matrix_j1, @hard_board)
    assert_equal(@board.first_matrix_j2, @hard_board)
    assert_equal(@board.second_matrix_j1, @hard_board)
    assert_equal(@board.second_matrix_j2, @hard_board)
    assert_equal(@board.difficulty, 2)
    assert_equal(@board.rows, 15)
  end
end

# Revisa lógica del tablero
class BoardTest < Test::Unit::TestCase
  def setup
    @board = Board.new
    @board.set_difficulty_easy
  end

  def test_place_horizontal_ship
    # Coloca un barco de largo 5 en la primera fila
    @board.place_horizontal_ship(1, 1, 5, 1)
    expected_j1 =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
       ['*', ' i ', ' m ', ' m ', ' m ', ' f ', '_', '_', '_', '_', '_', '*'],
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
    assert_equal(@board.first_matrix_j1, expected_j1)
  end

  def test_place_vertical_ship
    # coloca un barco de largo 4 desde board[4][5]
    @board.place_vertical_ship(5, 4, 7, 1)
    expected_j1 =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', ' i ', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', ' m ', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', ' m ', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', ' f ', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*']]
    assert_equal(@board.first_matrix_j1, expected_j1)
  end

  def test_place_x_first_player
    @board.add_attack_on_boards(1, 3, 3)
    expected =
      [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', ' - ', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
       ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*']]
    assert_equal(@board.first_matrix_j2, expected)
    assert_equal(@board.second_matrix_j1, expected)
  end

  def test_place_x_second_player
    @board.add_attack_on_boards(2, 6, 7)
    expected = 
    [['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', ' - ', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '*'],
     ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*']]
    assert_equal(@board.first_matrix_j1, expected)
    assert_equal(@board.second_matrix_j2, expected)
  end
end
