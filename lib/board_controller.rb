# frozen_string_literal: true

# Revisa logica del juego
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
    @view.print_player_board(@model, @player)
    ship_position
    @player = 2
    if @model.mode == 1
    #### TODO IMPLEMENTAR IA - AGREGAR BARCOS
      ai_ship_position
    else
      @view.print_player_turns(2)
      @view.print_player_board(@model, @player)
      ship_position
    end
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

  def ai_ship_position
    array = if @model.difficulty == 1
      [5, 4, 3, 3, 2]
    else
      [5, 5, 4, 4, 3, 3, 2, 2]
    end
    array.each do |size|
      ai_request_ship_position(size)
    end
  end
  
  def ai_request_ship_position(size)
    valid = false
    # generar posicion inicial random dentro de los limites
    x_pos = 1 + rand(@model.rows - 1)
    y_pos = 1 + rand(@model.rows - 1)
    # generar direccion valida
    direction = 1 + rand(1)
    direction_check = 0
    until valid 
      if direction == 1
        if x_pos + size - 1 > @model.rows
          direction = 2
          direction_check += 1
        else
          valid = true
        end
      else
        if y_pos + size - 1 > @model.rows
          direction = 1
          direction_check += 1
        else
          valid = true
        end
      end
      if direction_check == 2 
        x_pos = 1 + rand(@model.rows - 1)
        y_pos = 1 + rand(@model.rows - 1)
        direction = 1 + rand(1)
        direction_check = 0
      end        
    end
    ai_handle_ship_position(size, x_pos, y_pos, direction)
  end

  def ai_handle_ship_position(size, x, y, direction)
    matrix = @model.first_matrix_j2
    if direction == 1
      x_fin = x + size - 1
      # revisar colisiones
      (x..x_fin).each do |posicion|
        next unless (matrix[y][posicion] == ' i ') || (matrix[y][posicion] == ' m ') || (matrix[y][posicion] == ' f ')

        @view.print_error(2) #eliminar aviso de colision
        ai_request_ship_position(size)
        return nil
      end
      @model.place_horizontal_ship(x, y, x_fin, @player)
    else
      y_fin = y + size - 1
      # revisar colisiones
      (y..y_fin).each do |posicion|
        next unless (matrix[posicion][x] == ' i ') || (matrix[posicion][x] == ' m ') || (matrix[posicion][x] == ' f ')

        @view.print_error(2) # eliminar aviso de colision
        ai_request_ship_position(size)
        return nil 
      end
      @model.place_vertical_ship(x, y, y_fin, @player)
    end
    # No es necesario mostrar tablero de IA
    # Mostrar alguna cosa para dar feedback al player 1
    @view.print_player_board(@model, @player)
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
        return nil
      end
      (x..x_fin).each do |posicion|
        next unless (matrix[y][posicion] == ' i ') || (matrix[y][posicion] == ' m ') || (matrix[y][posicion] == ' f ')

        @view.print_error(2)
        request_ship_position_input(size)
        return nil
      end
      @model.place_horizontal_ship(x, y, x_fin, @player)
    else
      y_fin = y + size - 1
      if y_fin > @model.rows
        @view.print_error(1)
        request_ship_position_input(size)
        return nil
      end
      (y..y_fin).each do |posicion|
        next unless (matrix[posicion][x] == ' i ') || (matrix[posicion][x] == ' m ') || (matrix[posicion][x] == ' f ')

        @view.print_error(2)
        request_ship_position_input(size)
        return nil
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
      until win
        @view.print_player_turns(@player)
        if @player == 1
          print_boards
          @view.choose_atack
          shooter
        else
          ai_shooter
          # print_boards
        end
        win = @model.winner
      end
      @view.print_win(@player)
    else
      until win
        @view.print_player_turns(@player)
        print_boards
        @view.choose_atack
        shooter
        win = @model.winner
      end
      @view.print_win(@player)
    end
  end

  def shooter
    valido = false
    pos = 0
    matr2 = if @player == 1
              @model.first_matrix_j2
            else
              @model.first_matrix_j1
            end

    until valido
      pos = $stdin.gets.to_i
      x = (pos % @model.rows)
      x = @model.rows if x.zero?
      y = (((pos - 1) / @model.rows).floor + 1).to_i
      if (pos < 1) || (x > @model.rows) || (y > @model.rows)
        @view.print_error(0)
        @view.choose_atack
      elsif matr2[y][x] == ' I ' || matr2[y][x] == ' M ' || matr2[y][x] == ' F '
        @view.print_error(3)
        @view.choose_atack

      else
        valido = true
      end
    end
    @model.add_attack_on_boards(@player, y, x)

    if matr2[y][x] == ' I ' || matr2[y][x] == ' M ' || matr2[y][x] == ' F '
      @view.print_shot_ship
    else
      change_turn
    end
  end

  def ai_shooter
    x = 1 + rand(@model.rows - 1)
    y = 1 + rand(@model.rows - 1)
    # puts "jugador 2  #{x}, #{y} ataca #{(y - 1) * 10 + x}"
    @model.add_attack_on_boards(@player, y, x)
    matr2 = if @player == 1
              @model.first_matrix_j2
            else
              @model.first_matrix_j1
            end
    if matr2[y][x] == ' I ' || matr2[y][x] == ' M ' || matr2[y][x] == ' F '
      @view.print_shot_ship
    else 
      change_turn
    end
  end

  def change_turn
    @player = if @player == 1
                2
              else
                1
              end
  end
end
