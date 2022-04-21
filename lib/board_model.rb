# frozen_string_literal: true
require_relative './observer/observable'

class Board < Observable
    def initialize()
      super()
      @firstMatrix = []
      @secondMatrix = []
      @mode = 0
      @difficulty = 0
    end

    attr_accessor :mode
    attr_accessor :matrix
    attr_accessor :difficulty
    
    def setDifficultyEasy
      easyBoard = 
        [['*','*','*','*','*','*','*','*','*','*','*','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','*','*','*','*','*','*','*','*','*','*','*']]
      @firstMatrix = easyBoard.map(&:clone)
      @secondMatrix = easyBoard.map(&:clone)
    end

    def setDifficultyHard
      hardBoard = 
        [['*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','*'],
        ['*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*']]
      @firstMatrix = hardBoard.map(&:clone)
      @secondMatrix = hardBoard.map(&:clone)
    end

    def rows
      rowNumber = 0
      if @difficulty == 1
        rowNumber = 10
      else
        rowNumber = 15
      end
      rowNumber
    end

    # def mark(xo, yo, symbol)
    # # marcar simbolo en la coordenada especificada
    #   @matrix[xo][yo] = symbol
    #   notifyAll() # ??? como funciona
    # end

    # def symbolAt(xo,yo)
    # # imprime simbolo de la coordenada especificada
    #   @matrix[xo][yo]
    # end

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
