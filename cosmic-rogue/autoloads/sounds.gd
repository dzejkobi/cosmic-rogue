# Sounds

extends Node


var music := AudioPlayer.Music.new(
	"res://assets/music/trance5.ogg",
	{
		"volume": 0.6
	}
)


var click := AudioPlayer.Sound.new(
	"res://assets/sounds/click.ogg",
	{
		"volume": 0.6,
		"pitch_scale_variancy": 0.2
	},
	true
)

var enemy_dies := AudioPlayer.Sound.new(
	"res://assets/sounds/enemy_dies.ogg",
	{
		"volume": 0.6,
		"pitch_scale_variancy": 0.2
	},
	true
)

var footstep := AudioPlayer.Sound.new(
	"res://assets/sounds/footstep.ogg",
	{
		"volume": 0.6,
		"pitch_scale_variancy": 0.2
	},
	true
)

var game_over := AudioPlayer.Sound.new(
	"res://assets/sounds/game_over.ogg",
	{
		"volume": 0.8,
		"pitch_scale_variancy": 0.2
	},
	true
)

var laser := AudioPlayer.Sound.new(
	"res://assets/sounds/laser.ogg",
	{
		"volume": 0.6,
		"pitch_scale_variancy": 0.2
	},
	true
)

var victory := AudioPlayer.Sound.new(
	"res://assets/sounds/victory.ogg",
	{
		"volume": 0.8,
		"pitch_scale_variancy": 0.2
	},
	true
)
