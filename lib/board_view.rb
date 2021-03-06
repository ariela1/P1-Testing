# frozen_string_literal: true

require 'matrix'

# Vista del juego en consola
class BoardView
  def print_gamemode_options(first_attempt)
    if first_attempt
      print "Selecciona un modo de juego\n"
    else
      print "Opción no válida: Selecciona un modo de juego\n"
    end
    print "[1] Contra el computador\n"
    print "[2] Uno contra uno\n"
  end

  def print_gamedifficulty_options(first_attempt)
    if first_attempt
      print "\nSelecciona una dificultad\n"
    else
      print "\nOpción no válida: Selecciona una dificultad\n"
    end
    print "[1] Fácil\n"
    print "[2] Difícil\n"
  end

  def print_player_turns(player)
    puts "\nTurno del jugardor #{player}"
  end

  def print_player_board(board_model, player)
    puts "\nTABLERO DEL JUGADOR"
    print_board(board_model, player, 1)
  end

  def print_opponent_board(board_model, player)
    puts "\nTABLERO DEL OPONENTE"
    print_board(board_model, player, 2)
  end

  # La lógica cambia segun se imprime para el jugador o el oponente
  def print_board(board_model, player, type)
    pos = 1
    (1..board_model.rows).each do |i|
      print '|'
      (1..board_model.rows).each do |j|
        symbol = board_model.symbol_at(i, j, player, type)
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

  def print_ship_position_options(size)
    puts "\nSelecciona posicion para agregar barco de tamaño #{size}"
  end

  def print_ship_dimension_options
    print "\nSelecciona sentido del barco:\n"
    print "[1] Horizontal\n"
    print "[2] Vertical\n"
  end

  def print_error(code)
    case code
    when 0
      puts "\nCelda no se encuentra en el tablero"
    when 1
      puts "\nBarco no cabe en el tablero"
    when 2
      puts "\nCelda o celdas ocupadas por otro barco"
    when 3
      puts "\nYa has atacado en esta posicion"
    end
  end

  def start_shooting
    puts "\n¡Empieza el juego!"
  end

  def choose_atack
    puts "\nIntroduce en que celda quieres atacar:"
  end

  def print_shot_ship
    puts "\nHas hundido una parte del barco rival, tienes doble turno"
  end

  def print_win(player)
    puts "\n\nJugador #{player} gana"
  end
end
