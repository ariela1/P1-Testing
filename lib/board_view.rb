# frozen_string_literal: true
require  'matrix'
require_relative './observer/observer'

class BoardView < Observer
  
  def printGameModeOptions(firstAttempt)
    if firstAttempt
      print "Selecciona un modo de juego\n"
      print "[1] Contra el computador\n"
      print "[2] Uno contra uno\n"
    else
      print "Opción no válida: Selecciona un modo de juego\n"
      print "[1] Contra el computador\n"
      print "[2] Uno contra uno\n"
    end
  end

  def printGameDifficultyOptions(firstAttempt)
    if firstAttempt
      print "\nSelecciona una dificultad\n"
      print "[1] Fácil\n"
      print "[2] Difícil\n"
    else
      print "\nOpción no válida: Selecciona una dificultad\n"
      print "[1] Fácil\n"
      print "[2] Difícil\n"
    end
  end

  def printPlayerBoard(boardModel)
    puts "\nTABLERO DEL JUGADOR"
    printBoard(boardModel)
  end

  def printOpponentBoard(boardModel)
    puts "\nTABLERO DEL OPONENTE"
    printBoard(boardModel)
  end
  
  # La lógica cambia segun se imprime para el jugador o el oponente
  def printBoard(boardModel)
    pos = 1
    for i in 1..boardModel.rows
      print "|"
      for j in 1..boardModel.rows
        symbol = "_"
        if symbol == '_'
          if pos <= 9
            print " #{pos} |"
          elsif pos <= 99
            print " #{pos}|"
          else
            print "#{pos}|"
          end
        else
          print "#{symbol}|"
        end
        pos += 1
      end
      print "\n"
    end
    STDOUT.flush
  end


  
  # def printBoard(boardModel)
  #   pos = 1
  #   for i in 1..3
  #     print "|"
  #     for j in 1..3
  #       symbol = boardModel.symbolAt(i,j)
  #       if symbol == '_'
  #         print "#{pos}|"
  #       else
  #         print "#{symbol}|"
  #       end
  #       pos += 1
  #     end
  #     print "\n"
  #   end
  #   STDOUT.flush
  # end

  # def update(boardModel)
  #   # clean
  #   printBoard(boardModel)
  # end
  

  # def congratulate(playerSymbol)
  #   clean
  #   print "Player: #{playerSymbol} WINS\n"
  # end
  
  # def gameOver()
  #   clean
  #   print "GG - NO SKILL\n"
  # end

  # def clean
  #   # TODO
  # end


  # def printOptions(playerSymbol)
  #   print "select a position #{playerSymbol}\n"
  # end

end
