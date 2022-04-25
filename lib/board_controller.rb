# frozen_string_literal: true

# Revisa lógica del juego
class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
    @player = 0
  end

  def request_gamemode_input
    @view.print_gamemode_options(true)
    not_in_options = true
    key = 0
    while not_in_options
      key = $stdin.gets.to_i
      not_in_options = key != 1 && key != 2
      @view.print_gamemode_options(false) if not_in_options
    end
    handle_gamemode(key)
  end

  def request_gamedifficulty_input
    @view.print_gamedifficulty_options(true)
    not_in_options = true
    key = 0
    while not_in_options
      key = $stdin.gets.to_i
      not_in_options = key != 1 && key != 2
      @view.print_gamedifficulty_options(false) if not_in_options
    end
    handle_difficulty(key)
  end

  def handle_gamemode(key)
    @model.mode = key
    request_gamedifficulty_input
  end

  def handle_difficulty(diff)
    @model.difficulty = diff
    if diff == 1
      @model.set_difficulty_easy
    else
      @model.set_difficulty_hard
    end
  end

  def print_boards
    # HACER: ver si es necesario el metodo view.clean
    # @view.clean
    @view.print_player_board(@model, @player)
    @view.print_opponent_board(@model, @player)
  end

  def choice_ships
    @player = 1
    @view.print_player_turns(1)
    if @model.mode == 1
    #### TODO IMPLEMENTAR IA - AGREGAR BARCOS
    else
      @view.print_player_board(@model, @player)
      ship_position
      @player = 2
      @view.print_player_turns(2)
    end
    @view.print_player_board(@model, @player)
    ship_position
  end

  def ship_position
    array = if @model.difficulty == 1
              [5, 4, 3, 3, 2]
            else
              [5, 5, 4, 4, 3, 3, 2, 2]
            end
    array.each do |e|
      request_ship_position_input(e)
    end
  end

  def request_ship_position_input(size)
    @view.print_ship_position_options(size)
    valido = false
    pos = 0
    until valido
      pos = $stdin.gets.to_i
      x = (pos % @model.rows)
      x = @model.rows if x.zero?
      y = (((pos - 1) / @model.rows).floor + 1).to_i
      if (pos < 1) || (x > @model.rows) || (y > @model.rows)
        @view.print_error(0)
        @view.print_ship_position_options(size)
      else
        valido = true
      end
    end
    @view.print_ship_dimension_options
    not_in_options = true
    dim = 0
    while not_in_options
      dim = $stdin.gets.to_i
      not_in_options = dim != 1 && dim != 2
      @view.print_ship_dimension_options if not_in_options
    end
    handle_ship_position(size, pos, dim)
  end

  def handle_ship_position(size, pos, dim)
    matrix = if @player == 1
               @model.first_matrix_j1
             else
               @model.first_matrix_j2
             end
    x = (pos % @model.rows)
    x = @model.rows if x.zero?
    y = (((pos - 1) / @model.rows).floor + 1).to_i
    if dim == 1
      x_fin = x + size - 1
      if x_fin > @model.rows
        @view.print_error(1)
        request_ship_position_input(size)
        return
      end
      (x..x_fin).each do |posicion|
        next unless (matrix[y][posicion] == ' i ') || (matrix[y][posicion] == ' m ') || (matrix[y][posicion] == ' f ')

        @view.print_error(2)
        request_ship_position_input(size)
      end
      @model.place_horizontal_ship(x, y, x_fin, @player)
    else
      y_fin = y + size - 1
      if y_fin > @model.rows
        @view.print_error(1)
        request_ship_position_input(size)
      end
      (y..y_fin).each do |posicion|
        next unless (matrix[posicion][x] == ' i ') || (matrix[posicion][x] == ' m ') || (matrix[posicion][x] == ' f ')

        @view.print_error(2)
        request_ship_position_input(size)
      end
      @model.place_vertical_ship(x, y, y_fin, @player)
    end
    @view.print_player_board(@model, @player)
  end

  def begin_game
    @player = 1
    @view.start_shooting
    win = false

    if @model.mode == 1
      #### IMPLEMENTAR IA
    else
      until win  ## FALTA IMPLEMENTAR EL SISTEMA DE GANAR
        @view.print_player_turns(@player)
        print_boards
        @view.choose_atack
        shooter
        print_boards
        # VER SI GANO
        change_turn
      end 
    end
  end

  def shooter
    valido = false
    pos = 0
    until valido
      pos = $stdin.gets.to_i
      x = (pos % @model.rows)
      x = @model.rows if x.zero?
      y = (((pos - 1) / @model.rows).floor + 1).to_i
      if (pos < 1) || (x > @model.rows) || (y > @model.rows)
        @view.print_error(0)
        @view.choose_atack
      else
        valido = true
      end
    end
    @model.add_attack_on_boards(@player, y, x) 
  end

  def change_turn
    @player = if @player == 1
                2
              else
                1
              end
  end


end




"""
    a = 1
    while a == 1
      attack = choose_atack
      puts ' '
      puts 'PLAYER ' + @player.to_s + ' ATTACKED POSITION ' + attack.to_s
      print_boards
      finish_turn
      change_turn
    end
  end

 

 

  def choose_atack
    print_boards
    attack = gets.chomp
    attack
  end

  def finish_turn
    puts ' '
    puts 'PRESS ENTER TO FINISH YOUR TURN:'
    attack = gets.chomp
    attack
  end
end
"""
