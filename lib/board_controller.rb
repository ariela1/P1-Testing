# frozen_string_literal: true

class BoardController 

  def initialize(boardModel, boardView)
    @model = boardModel
    @view = boardView
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
      printPlayerAndOpponentBoards
      shipPosition(diff)
      #requestShipPositionInput
    else
      @model.setDifficultyHard
      printPlayerAndOpponentBoards
      shipPosition(diff)
      #requestShipPositionInput
    end
  end

  def printPlayerAndOpponentBoards
    # HACER: ver si es necesario el metodo view.clean 
    # @view.clean
    @view.printPlayerBoard(@model)
    @view.printOpponentBoard(@model)
  end


## Inicio de la creacion de los barcos
  def shipPosition(diff)
    if diff == 1
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
    notInOptions = true
    pos = 0
    while notInOptions
      pos = $stdin.gets.to_i
      notInOptions = pos < 1
      x = (pos % @model.rows)
      if x == 0
         x = @model.rows
      end 
      y = ((((pos -1) / @model.rows).floor())+1).to_i
      # puts "X: #{x}"
      # puts "Y: #{y}"
    

      if notInOptions or x > @model.rows or y > @model.rows  
        @view.printErrorShipPosition(0)
        @view.printShipPositionOptions(size)
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
    # FALTAA ver que no haya otro barco    
    x = (pos % @model.rows)
      if x == 0
         x = @model.rows
      end 
    y = ((((pos -1) / @model.rows).floor())+1).to_i
    
        
    if dim == 1
      x_fin = x + size - 1
      # puts "X: #{x_fin}"
      if x_fin > @model.rows  
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
      end
      
      for posicion in x..x_fin do
        if @model.firstMatrix[y][posicion] == " i " or @model.firstMatrix[y][posicion] == " m " or @model.firstMatrix[y][posicion] == " f "  
          @view.printErrorShipPosition(2)
          requestShipPositionInput(size)
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
  
      printPlayerAndOpponentBoards
      
    else
      y_fin = y + size -1
      if y_fin > @model.rows  
        @view.printErrorShipPosition(1)
        requestShipPositionInput(size)
      end

      for posicion in y..y_fin do
        if @model.firstMatrix[posicion][y] == " i " or @model.firstMatrix[posicion][y] == " m " or @model.firstMatrix[posicion][y] == " f "  
          @view.printErrorShipPosition(2)
          requestShipPositionInput(size)
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

      printPlayerAndOpponentBoards
    
    end    
  end

  def addShipToBoard(x,y,pos)
    @model.mark(x,y,pos,1)
    # printPlayerAndOpponentBoards
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
