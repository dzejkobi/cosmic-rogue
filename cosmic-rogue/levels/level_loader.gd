class_name LevelLoader extends Node

const TERRAIN_CHAR_MAP = {
	" ": Enums.TERRAIN_TYPE.FLOOR,
	"x": Enums.TERRAIN_TYPE.WALL,
	"o": Enums.TERRAIN_TYPE.ROCKS
}

const ACTOR_CHAR_MAP: Dictionary = {
	"": {
		"type": Enums.ACTOR_TYPE.UNKNOWN,
		"scene": null
	},
	" ": {
		"type": Enums.ACTOR_TYPE.NONE,
		"scene": null
	},
	"p": { 
		"type": Enums.ACTOR_TYPE.PLAYER,
		"scene": preload("res://actors/player.tscn")
	},
	"m": {
		"type": Enums.ACTOR_TYPE.MANIPULANT,
		"scene": preload("res://actors/manipulant.tscn")
	},
	"r": {
		"type": Enums.ACTOR_TYPE.RECRUITER,
		"scene": preload("res://actors/recruiter.tscn")
	}
}

@export var level_names: Array[String] = [
	"level1"
]
@export var curr_level_index: int = 0


func read_cell_from_str(cell_str: String) -> Array:
	if len(cell_str) == 1:
		cell_str += ' '
	assert(
		len(cell_str) == 2,
		"Parameter cell_str should be a String of length 2."
	)
	var terrain_type: Enums.TERRAIN_TYPE = TERRAIN_CHAR_MAP.get(
		cell_str[0], Enums.TERRAIN_TYPE.UNKNOWN
	)
	var actor_def: Dictionary = ACTOR_CHAR_MAP.get(
		cell_str[1], ACTOR_CHAR_MAP[""]
	)
	assert(terrain_type, "Unknown terrain type.")
	assert(actor_def["type"], "Unknown actor type.")
	return [terrain_type, actor_def]
	

func setup_board(board: Board):
	var grid: Grid = board.grid
	var grid_pos: Vector2i
	var actor: Actor = null
	var cell_def: Array
	var level_def: String
	
	level_def = FileAccess.get_file_as_string(
		"res://levels/%s.txt" % level_names[curr_level_index]
	).strip_edges()
	grid.size = Vector2i.ZERO
	
	grid_pos = Vector2.ZERO
	for row: String in level_def.split("\n"):
		grid_pos.x = 0
		for index in range(0, len(row), 2):
			cell_def = read_cell_from_str(row.substr(index, 2))
			if cell_def[1]["scene"]:
				actor = cell_def[1]["scene"].instantiate()
				actor.setup(grid_pos)
				board.add_child(actor)
				if actor is Player:
					board.player = actor
				elif actor.is_enemy:
					board.enemies.append(actor)
			else:
				actor = null
			
			grid.cells[grid_pos] = GridCell.new(cell_def[0], actor)
			grid_pos.x += 1
		grid_pos.y += 1
		
	grid.size = grid_pos
	
	
func set_next_level(level_index: int = -1) -> void:
	if level_index == -1:
		curr_level_index += 1
		if curr_level_index >= level_names.size():
			curr_level_index = 0
	else:
		curr_level_index = level_index
	%LevelLabel.text = "Level: %s" % (curr_level_index + 1)
