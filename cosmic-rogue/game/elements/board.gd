class_name Board extends Node

@export var grid: Grid
@export var level_def: String
@export var is_paused: bool = true

var size: Vector2i = Vector2i.ZERO
var player: Player
var enemies: Array[Actor] = []

var is_set: bool = false

var score: int = 0:
	set(value):
		score = value
		%ScoreLabel.text = "Score: %s" % score
	get():
		return score

@onready var terrain_layer: TerrainLayer = $TerrainLayer
@onready var actor_layer: Node2D = $ActorLayer
@onready var camera: Camera2D = %Camera
@onready var level_loader: LevelLoader = %LevelLoader

@warning_ignore("unused_signal")
signal player_movement_started(player: Actor)
@warning_ignore("unused_signal")
signal player_movement_finished(player: Actor)


func center_camera() -> void:
	var screen_size: Vector2i = get_viewport().get_visible_rect().size
	camera.position = floor(screen_size / 2.0)
	
	
func _ready() -> void:
	center_camera()
	AudioPlayer.setup(%AudioListener)


func setup() -> void:
	if player:
		player.queue_free()
		player = null
	for enemy: Actor in enemies:
		enemy.queue_free()
	enemies.clear()
	grid.cleanup()
	level_loader.setup_board(self)
	terrain_layer.update_tilemaps(grid)
	is_set = true


func reset() -> void:
	score = 0
	level_loader.set_next_level(0)
	setup()


func game_over() -> void:
	%GameOverPanel.display(level_loader.curr_level_index + 1, score)
	Sounds.game_over.play()
	is_paused = true
	is_set = false


func complete_level() -> void:
	Sounds.victory.play()
	level_loader.set_next_level()
	setup()


func check_level_completion() -> void:
	if is_set and not enemies.size():
		complete_level()
