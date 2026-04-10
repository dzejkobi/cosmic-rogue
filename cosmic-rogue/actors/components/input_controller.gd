class_name InputController extends Node

@onready var actor: Actor = get_parent()


func _process(_delta: float) -> void:
	if Globals.board.is_paused or not actor or actor.is_moving:
		return

	var direction := Vector2i.ZERO
	var to_grid_pos: Vector2i

	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2i.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2i.RIGHT
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2i.UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2i.DOWN
	
	if direction == Vector2i.ZERO:
		return
	
	to_grid_pos = actor.grid_pos + direction
	if actor.is_movement_valid(to_grid_pos):
		actor.move_to_cell(to_grid_pos)
