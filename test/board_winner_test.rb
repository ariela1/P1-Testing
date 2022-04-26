# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class Winner < Test::Unit::TestCase
    
    def setup
        @board = Board.new
    end

    def test_j1_winner_easy
        @board.set_difficulty_easy
        @board.j1_attack = 17
        assert_equal(@board.winner, true)
    end

    def test_j1_winner_hard
        @board.set_difficulty_hard
        @board.j1_attack = 28
        assert_equal(@board.winner, true)
    end

    def test_j2_winner_easy
        @board.set_difficulty_easy
        @board.j2_attack = 17
        assert_equal(@board.winner, true)
    end

    def ters_j2_winner_hard
        @board.set_difficulty_hard
        @board.j2_attack = 28
        assert_equal(@board.winner, true)
    end
end 