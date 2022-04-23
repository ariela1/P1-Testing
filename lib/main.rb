# frozen_string_literal: true

require_relative './board_model'
require_relative './board_controller'
require_relative './board_view'

model = Board.new
view = BoardView.new
model.addObserver(view)
controller = BoardController.new(model, view)
# controller.printBoard
controller.request_gamemode_input
# controller.requestInput
controller.choice_ships
