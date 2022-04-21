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
    else
      @model.setDifficultyHard
      printPlayerAndOpponentBoards
    end
  end

  def printPlayerAndOpponentBoards
    # HACER: ver si es necesario el metodo view.clean 
    # @view.clean
    @view.printPlayerBoard(@model)
    @view.printOpponentBoard(@model)
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
