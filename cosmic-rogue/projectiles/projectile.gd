class_name Projectile extends Node2D

@export var speed: float = 800.0  # pixels / sec

var to_grid_pos: Vector2i


func move_to(_to_grid_pos: Vector2i) -> void:
	to_grid_pos = _to_grid_pos
	
	var to_pos: Vector2 = Grid.grid_pos_to_pos(to_grid_pos)
	var distance: float = position.distance_to(to_pos)
	var duration: float = distance / speed
	var tween = create_tween()
	
	tween.tween_property(self, "position", to_pos, duration)
	tween.tween_callback(_at_target_reached)
	
	
func _at_target_reached() -> void:
	var cell: GridCell = Globals.board.grid.cells.get(to_grid_pos)
	if cell and cell.actor:
		cell.actor.hit_by_projectile(self)
	queue_free()
