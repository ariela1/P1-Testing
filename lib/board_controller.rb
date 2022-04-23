# frozen_string_literal: true

class BoardController 

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
      if notInOptions
        @view.printGameModeOptions(false)
      end
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
      if notInOptions
        @view.printGameDifficultyOptions(false)
      end 
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
    if @model.mode == 1
      @player = 1
      @view.printPlayersTurns(1)
      @view.printPlayerBoard(@model, @player)
      shipPosition
      #### TODO IMPLEMENTAR IA - AGREGAR BARCOS
    else
      @player = 1
      @view.printPlayersTurns(1)
      @view.printPlayerBoard(@model, @player)
      shipPosition
      @player = 2
      @view.printPlayersTurns(2)
      @view.printPlayerBoard(@model, @player)
      shipPosition
    end
  end 

  def shipPosition
    if @model.difficulty == 1
      array = [5,4,3,3,2]
    else
      array = [5,5,4,4,3,3,2,2]
    end 
    array.each do |e| 
      requestShipPositionInput(e)
    end
  end

  def requestShipPositionInput(size)
    @view.printShipPositionOptions(size)
    valido = false
    pos = 0
    while not valido
      pos = $stdin.gets.to_i
      x = (pos % @model.rows)
      if x == 0
         x = @model.rows
      end 
      y = ((((pos -1) / @model.rows).floor())+1).to_i    
      if pos < 1 or x > @model.rows or y > @model.rows  
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
      if notInOptions
        @view.printShipDimensionOptions
      end
    end
    handleShipPosition(size, pos, dim)
  end

  def handleShipPosition(size, pos, dim)
    if @player == 1
      matrix = @model.firstMatrixJ1
    else 
      matrix = @model.firstMatrixJ2
    end
    x = (pos % @model.rows)
      if x == 0
         x = @model.rows
      end 
    y = ((((pos -1) / @model.rows).floor())+1).to_i
    if dim == 1
      x_fin = x + size - 1
      if x_fin > @model.rows  
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
        return
      end
      for posicion in x..x_fin do
        if matrix[y][posicion] == " i " or matrix[y][posicion] == " m " or matrix[y][posicion] == " f "  
          @view.printErrorShipPosition(2)
          requestShipPositionInput(size)
          return
        end
      end
      for posicion in x..x_fin do
        if posicion == x
          addShipToBoard(y, posicion, " i ")
        elsif posicion == x_fin
          addShipToBoard(y, posicion, " f ")
        else
          addShipToBoard(y, posicion, " m ")
        end 
      end  
      @view.printPlayerBoard(@model, @player)  
    else
      y_fin = y + size -1
      if y_fin > @model.rows  
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
        return
      end
      for posicion in y..y_fin do
        if matrix[posicion][x] == " i " or matrix[posicion][x] == " m " or matrix[posicion][x] == " f "  
          @view.printErrorShipPosition(2)
          requestShipPositionInput(size)
          return
        end
      end
      for posicion in y..y_fin do
        if posicion == y
          addShipToBoard(posicion, x, " i ")
        elsif posicion == y_fin
          addShipToBoard(posicion, x, " f ")
        else
          addShipToBoard(posicion, x, " m ")
        end 
      end
      @view.printPlayerBoard(@model, @player)
    end    
  end

  def addShipToBoard(x,y,pos)
    @model.mark(x,y,pos,@player,1)
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
