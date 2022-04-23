# frozen_string_literal: true

require_relative './observer/observable'

# Modelo del tablero
class Board < Observable
  attr_accessor :mode, :firstMatrixJ1, :secondMatrixJ1, :firstMatrixJ2, :secondMatrixJ2, :difficulty

  def initialize
    super()
    @firstMatrixJ1 = []
    @secondMatrixJ1 = []
    @firstMatrixJ2 = []
    @secondMatrixJ2 = []
    @mode = 0
    @difficulty = 0
  end

  def setDifficultyEasy
    easyBoard =
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
    @firstMatrixJ1 = easyBoard.map(&:clone)
    @secondMatrixJ1 = easyBoard.map(&:clone)
    @firstMatrixJ2 = easyBoard.map(&:clone)
    @secondMatrixJ2 = easyBoard.map(&:clone)
  end

  def setDifficultyHard
    hardBoard =
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
    @firstMatrixJ1 = hardBoard.map(&:clone)
    @secondMatrixJ1 = hardBoard.map(&:clone)
    @firstMatrixJ2 = hardBoard.map(&:clone)
    @secondMatrixJ2 = hardBoard.map(&:clone)
  end

  def rows
    if @difficulty == 1
      10
    else
      15
    end
  end

  def mark(xo, yo, symbol, player, type)
    # marcar simbolo en la coordenada especificada
    if player == 1
      if type == 1
        @firstMatrixJ1[xo][yo] = symbol
      else
        @secondMatrixJ1[xo][yo] = symbol
      end
    elsif type == 1
      @firstMatrixJ2[xo][yo] = symbol
    else
      @secondMatrixJ2[xo][yo] = symbol
    end
  end

  def symbolAt(xo, yo, player, type)
    if player == 1
      if type == 1
        @firstMatrixJ1[xo][yo]
      else
        @secondMatrixJ1[xo][yo]
      end
    elsif type == 1
      @firstMatrixJ2[xo][yo]
    else
      @secondMatrixJ2[xo][yo]
    end
  end

  # def winner(symbol)
  #   for i in 1..3
  #     for j in 1..3
  #       if (@matrix[i][j] == symbol && sameNeighbors(i,j,symbol))
  #           return true
  #       end
  #     end
  #   end
  #   return false
  # end

  # def sameNeighbors(xo, yo, symbol)
  #   return (@matrix[xo][yo - 1] == symbol && @matrix[xo][yo + 1] == symbol) ||  (@matrix[xo - 1][yo] == symbol && @matrix[xo + 1][yo] == symbol) || (@matrix[xo - 1][yo - 1] == symbol && @matrix[xo + 1][yo + 1] == symbol) || (@matrix[xo + 1][yo - 1] == symbol && @matrix[xo - 1][yo + 1] == symbol)
  # end

  # def getMark(x,y)
  #   return @matrix[x][y]
  # end

  # def isFull
  #   counter = 0
  #   for i in 1..3
  #     for j in 1..3
  #       if (@matrix[i][j] == '_')
  #           counter += 1
  #       end
  #     end
  #   end
  #   return counter == 0
  # end

  # def equal(otherBoard)
  #   for i in 1..3
  #     for j in 1..3
  #       if @matrix[i][j] != otherBoard.getMark(i,j)
  #           return false
  #       end
  #     end
  #   end
  #   return true
  # end
end
