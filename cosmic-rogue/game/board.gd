class_name Board extends Node

@export var grid: Grid
@export var level: Level

var size: Vector2i = Vector2i.ZERO
var player: Player
var enemies: Array[Actor] = []

@onready var terrain_layer: TerrainLayer = $TerrainLayer
@onready var actor_layer: Node2D = $ActorLayer

@warning_ignore("unused_signal")
signal player_movement_started(player: Actor)
@warning_ignore("unused_signal")
signal player_movement_finished(player: Actor)


func reset() -> void:
	if player:
		player.queue_free()
		player = null
	for enemy: Actor in enemies:
		enemy.queue_free()
	enemies.clear()
	grid.cleanup()
	level.setup_board(self)
	terrain_layer.update_tilemaps(grid)


func setup() -> void:
	reset()
	

func game_over() -> void:
	reset()
	
	
func complete_level() -> void:
	reset()
