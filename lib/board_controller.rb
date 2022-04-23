# frozen_string_literal: true

# Revisa lógica del juego
class BoardController
  attr_accessor :player

  def initialize(boardModel, boardView)
    @model = boardModel
    @view = boardView
    @player = 0
  end

  def requestGameModeInput
    @view.printGameModeOptions(true)
    notInOptions = true
    key = 0
    while notInOptions
      key = $stdin.gets.to_i
      notInOptions = key != 1 && key != 2
      @view.printGameModeOptions(false) if notInOptions
    end
    handleGameMode(key)
  end

  def requestGameDifficultyInput
    @view.printGameDifficultyOptions(true)
    notInOptions = true
    key = 0
    while notInOptions
      key = $stdin.gets.to_i
      notInOptions = key != 1 && key != 2
      @view.printGameDifficultyOptions(false) if notInOptions
    end
    handleDifficulty(key)
  end

  def handleGameMode(key)
    @model.mode = key
    requestGameDifficultyInput
  end

  def handleDifficulty(diff)
    @model.difficulty = diff
    if diff == 1
      @model.setDifficultyEasy
    else
      @model.setDifficultyHard
    end
  end

  def printPlayerAndOpponentBoards
    # HACER: ver si es necesario el metodo view.clean
    # @view.clean
    @view.printPlayerBoard(@model, @player)
    @view.printOpponentBoard(@model, @player)
  end

  def choiceShips
    @player = 1
    @view.printPlayersTurns(1)
    if @model.mode == 1
    #### TODO IMPLEMENTAR IA - AGREGAR BARCOS
    else
      @view.printPlayerBoard(@model, @player)
      shipPosition
      @player = 2
      @view.printPlayersTurns(2)
    end
    @view.printPlayerBoard(@model, @player)
    shipPosition
  end

  def shipPosition
    array = if @model.difficulty == 1
              [5, 4, 3, 3, 2]
            else
              [5, 5, 4, 4, 3, 3, 2, 2]
            end
    array.each do |e|
      requestShipPositionInput(e)
    end
  end

  def requestShipPositionInput(size)
    @view.printShipPositionOptions(size)
    valido = false
    pos = 0
    until valido
      pos = $stdin.gets.to_i
      x = (pos % @model.rows)
      x = @model.rows if x.zero?
      y = (((pos - 1) / @model.rows).floor + 1).to_i
      if (pos < 1) || (x > @model.rows) || (y > @model.rows)
        @view.printErrorShipPosition(0)
        @view.printShipPositionOptions(size)
      else
        valido = true
      end
    end
    @view.printShipDimensionOptions
    notInOptions = true
    dim = 0
    while notInOptions
      dim = $stdin.gets.to_i
      notInOptions = dim != 1 && dim != 2
      @view.printShipDimensionOptions if notInOptions
    end
    handleShipPosition(size, pos, dim)
  end

  def handleShipPosition(size, pos, dim)
    matrix = if @player == 1
               @model.firstMatrixJ1
             else
               @model.firstMatrixJ2
             end
    x = (pos % @model.rows)
    x = @model.rows if x.zero?
    y = (((pos - 1) / @model.rows).floor + 1).to_i
    if dim == 1
      x_fin = x + size - 1
      if x_fin > @model.rows
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
        return
      end
      (x..x_fin).each do |posicion|
        next unless (matrix[y][posicion] == ' i ') || (matrix[y][posicion] == ' m ') || (matrix[y][posicion] == ' f ')

        @view.printErrorShipPosition(2)
        requestShipPositionInput(size)
        return
      end
      (x..x_fin).each do |posicion|
        if posicion == x
          addShipToBoard(y, posicion, ' i ')
        elsif posicion == x_fin
          addShipToBoard(y, posicion, ' f ')
        else
          addShipToBoard(y, posicion, ' m ')
        end
      end
    else
      y_fin = y + size - 1
      if y_fin > @model.rows
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
        return
      end
      (y..y_fin).each do |posicion|
        next unless (matrix[posicion][x] == ' i ') || (matrix[posicion][x] == ' m ') || (matrix[posicion][x] == ' f ')

        @view.printErrorShipPosition(2)
        requestShipPositionInput(size)
        return
      end
      (y..y_fin).each do |posicion|
        if posicion == y
          addShipToBoard(posicion, x, ' i ')
        elsif posicion == y_fin
          addShipToBoard(posicion, x, ' f ')
        else
          addShipToBoard(posicion, x, ' m ')
        end
      end
    end
    @view.printPlayerBoard(@model, @player)
  end

  def addShipToBoard(x, y, pos)
    @model.mark(x, y, pos, @player, 1)
  end

  # def printBoard
  #   # HACER: ver si es necesario el metodo view.clean
  #   # @view.clean
  #   @view.printBoard(@model)
  # end

  # def requestInput
  #   @view.printOptions(@playerSymbol)
  #   key = $stdin.gets.to_i
  #   puts key
  #   x = (key/3.0).ceil
  #   y = (key%3).to_i
  #   if y == 0
  #     y = 3
  #   end
  #   select(x,y)
  # end

  # def select(xo,yo)
  #   @model.mark(xo,yo,@playerSymbol)
  #   if @model.winner(@playerSymbol)
  #     @view.congratulate(@playerSymbol)
  #   else
  #     swapPlayer
  #     if @model.isFull
  #       @view.gameOver
  #     else
  #       requestInput
  #     end
  #   end
  #   @view.clean
  # end

  # # hacer: no es necesario, o cambiar a señalar el turno
  # def swapPlayer
  #   if @playerSymbol == 'O'
  #     @playerSymbol = 'X'
  #   else
  #     @playerSymbol = 'O'
  #   end
  # end
end
