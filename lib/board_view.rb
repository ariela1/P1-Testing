# frozen_string_literal: true

require 'matrix'
require_relative './observer/observer'

# Vista del juego en consola
class BoardView < Observer
  def printGameModeOptions(firstAttempt)
    if firstAttempt
      print "Selecciona un modo de juego\n"
    else
      print "Opción no válida: Selecciona un modo de juego\n"
    end
    print "[1] Contra el computador\n"
    print "[2] Uno contra uno\n"
  end

  def printGameDifficultyOptions(firstAttempt)
    if firstAttempt
      print "\nSelecciona una dificultad\n"
    else
      print "\nOpción no válida: Selecciona una dificultad\n"
    end
    print "[1] Fácil\n"
    print "[2] Difícil\n"
  end

  def printPlayersTurns(player)
    puts "\nTurno del jugardor #{player}"
  end

  def printPlayerBoard(boardModel, player)
    puts "\nTABLERO DEL JUGADOR"
    printBoard(boardModel, player, 1)
  end

  def printOpponentBoard(boardModel, player)
    puts "\nTABLERO DEL OPONENTE"
    printBoard(boardModel, player, 2)
  end

  # La lógica cambia segun se imprime para el jugador o el oponente
  def printBoard(boardModel, player, type)
    pos = 1
    (1..boardModel.rows).each do |i|
      print '|'
      (1..boardModel.rows).each do |j|
        symbol = boardModel.symbolAt(i, j, player, type)
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
    $stdout.flush
  end

  def printShipPositionOptions(size)
    puts "\nSelecciona posicion para agregar barco de tamaño #{size}"
  end

  def printShipDimensionOptions
    print "\nSelecciona sentido del barco:\n"
    print "[1] Horizontal\n"
    print "[2] Vertical\n"
  end

  def printErrorShipPosition(code)
    case code
    when 0
      puts "\nCelda no se encuentra en el tablero"
    when 1
      puts "\nBarco no cabe en el tablero"
    when 2
      puts "\nCelda o celdas ocupadas por otro barco"

    end
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
  # clean
  # printBoard(boardModel)
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
