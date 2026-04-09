class_name Player extends Actor


func move_to_cell(to_grid_pos: Vector2i) -> void:
	super.move_to_cell(to_grid_pos)
	Globals.board.player_movement_started.emit(self)
	
	
func movement_finished_callback() -> void:
	super.movement_finished_callback()
	Globals.board.player_movement_finished.emit(self)
