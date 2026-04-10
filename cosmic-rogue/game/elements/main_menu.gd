class_name MainMenu extends CenterContainer

@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var resume_btn: Button = %ResumeBtn


func _ready() -> void:
	resume_btn.grab_focus()


func toggle() -> void:
	Sounds.click.play()
	visible = not visible
	Globals.board.is_paused = visible
	if visible:
		resume_btn.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()


func _on_resume_btn_pressed() -> void:
	toggle()


func _on_new_game_btn_pressed() -> void:
	Globals.board.reset()
	toggle()


func _on_settings_btn_pressed() -> void:
	toggle()
	settings_menu.toggle()


func _on_quit_btn_pressed() -> void:
	Sounds.click.play()
	get_tree().quit()
