extends PanelContainer

@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var score_label: Label = $VBoxContainer/ScoreLabel


func display(level: int, score: int) -> void:
	level_label.text = "You died on level: %s" % level
	score_label.text = "with score: %s" % score
	visible = true
	
	
func _unhandled_input(event):
	if (
		visible and (
			event is InputEventKey and event.pressed or
			event is InputEventMouseButton and event.pressed
		)
	):
		visible = false
		%MainMenu.toggle()
