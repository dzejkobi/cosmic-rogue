class_name Actor extends Node2D

@export var movement_duration: float = 0.5
@export var color_name: String
@export var is_enemy: bool = true

var is_moving: bool = false
var grid_pos: Vector2i

@onready var anim_sprite: AnimatedSprite2D = $AnimSprite


func setup(_grid_pos: Vector2i) -> void:
	grid_pos = _grid_pos
	position = Grid.grid_pos_to_pos(grid_pos)


func _ready() -> void:
	if color_name:
		var color: Color = Colors.get(color_name)
		if color:
			anim_sprite.modulate = color


func is_movement_valid(to_grid_pos: Vector2i) -> bool:
	var target_cell: GridCell = Globals.grid.cells.get(to_grid_pos)
	return target_cell and target_cell.is_passable()


func movement_finished_callback() -> void:
	anim_sprite.play("idle")
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

	# final position has to be set immidiately
	Globals.grid.cells[grid_pos].actor = null
	Globals.grid.cells[to_grid_pos].actor = self
	grid_pos = to_grid_pos

	anim_sprite.play("walking")
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self, "position", target_pos, movement_duration
	)
	tween.tween_callback(movement_finished_callback)


func die() -> void:
	queue_free()


func hit_by_projectile(projectile: Projectile) -> void:
	die()
