class_name Grid extends Node


var size: Vector2i = Vector2i.ZERO
var cells: Dictionary[Vector2i, GridCell] = {}


# helper functions

static func pos_to_grid_pos(pos: Vector2) -> Vector2i:
	return Vector2i(
		round(pos.x / float(Consts.TILE_SIZE.x)),
		round(pos.y / float(Consts.TILE_SIZE.y))
	)


static func grid_pos_to_pos(grid_pos: Vector2i) -> Vector2:
	return Vector2(
		grid_pos.x * Consts.TILE_SIZE.x,
		grid_pos.y * Consts.TILE_SIZE.y
	)

# ------


func cleanup() -> void:
	for grid_pos: Vector2i in cells:
		cells.erase(grid_pos)
	size = Vector2i.ZERO
