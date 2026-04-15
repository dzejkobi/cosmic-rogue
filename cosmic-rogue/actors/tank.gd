class_name Tank extends Actor

@export var direction: Vector2i = Vector2i.UP


static func get_dir_name(_direction: Vector2i) -> String:
	match _direction:
		Vector2i.UP:
			return "up"
		Vector2i.RIGHT:
			return "right"
		Vector2i.DOWN:
			return "down"
		Vector2i.LEFT:
			return "left"
		_:
			push_error('Unknown direction vector "%s".' % _direction)
			return ""


func _movement_finished_callback() -> void:
	anim_sprite.play("idle_%s" % get_dir_name(direction))
	position = Grid.grid_pos_to_pos(grid_pos)
	is_moving = false
	
	
func move_to_cell(to_grid_pos: Vector2i) -> void:
	var target_pos: Vector2 = Grid.grid_pos_to_pos(to_grid_pos)
	var tween: Tween = create_tween()
	
	assert(not is_moving, "Can't move already moving actor.")
	assert(
		is_movement_valid(to_grid_pos),
		"Invalid movement to %s." % to_grid_pos
	)
	
	is_moving = true
	direction = to_grid_pos - grid_pos

	# final position has to be set immidiately
	Globals.grid.cells[grid_pos].actor = null
	Globals.grid.cells[to_grid_pos].actor = self
	prev_grid_pos = grid_pos
	grid_pos = to_grid_pos

	anim_sprite.play("moving_%s" % get_dir_name(direction))
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self, "position", target_pos, movement_time
	)
	tween.tween_callback(_movement_finished_callback)
	
	var timer: SceneTreeTimer = get_tree().create_timer(0.1 * movement_time)
	timer.timeout.connect(func ():
		# we need to wait until all actors updates their grid positions
		try_to_shoot()
	)
	

func find_enemies_in_range() -> Array[Actor]:
	var player = Globals.board.player
	
	if (grid_pos.x == player.grid_pos.x or grid_pos.y == player.grid_pos.y):
		return [player]
	else:
		return []
		
		
func shoot(target: Actor) -> void:
	var timer := get_tree().create_timer(0.4 * movement_time)
	var player: Player = Globals.board.player
	
	timer.timeout.connect(func ():
		var dir_name: String
		if grid_pos.x == player.grid_pos.x:
			direction = Vector2i.DOWN if grid_pos.y < player.grid_pos.y \
				else Vector2i.UP
		elif grid_pos.y == player.grid_pos.y:
			direction = Vector2i.RIGHT if grid_pos.x < player.grid_pos.x \
				else Vector2i.LEFT
		dir_name = get_dir_name(direction)
		if prev_grid_pos == grid_pos:
			anim_sprite.play("idle_%s" % dir_name)
		else:
			anim_sprite.play("moving_%s" % dir_name)
		super.shoot(target)
	)

	
