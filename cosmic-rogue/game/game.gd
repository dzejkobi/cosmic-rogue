class_name Game extends Control

@onready var board: Board = %Board


func _ready() -> void:
	RenderingServer.set_default_clear_color(Colors.bg_color)
	Globals.set_board(board)
