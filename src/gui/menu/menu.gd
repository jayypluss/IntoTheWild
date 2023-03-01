extends Control


@onready var buttons_container := $ButtonsContainer
@onready var start_button := $ButtonsContainer/StartButton
@onready var credits_button := $ButtonsContainer/CreditsButton
@onready var exit_button := $ButtonsContainer/ExitButton
@onready var game_version_label := $Version/GameVersion
@onready var godot_version_label := $Version/GodotVersion


func _ready():
	game_version_label.text = "0.1-alpha"
#	game_version_label.text = ProjectSettings.get_setting("application/config/version")
	godot_version_label.text = "Godot %s" % Engine.get_version_info().string
	# needed for gamepads to work
	start_button.grab_focus()
	if OS.has_feature('HTML5'):
		exit_button.queue_free()
			
	if OS.has_feature("standalone"):
		$Music.play()
		
#	if !OS.has_feature("standalone"):
#		await get_tree().create_timer(0.5).timeout
#		get_tree().change_scene_to_file("res://src/levels/level_test/level_test.tscn")



func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to_file("res://src/levels/level_1/level_1.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_CreditsButton_pressed():
	$CreditsScreen.togle_visible(true)


func _on_test_level_pressed():
	get_tree().change_scene_to_file("res://src/levels/level_test/level_test.tscn")
	
func _on_level1_pressed():
	get_tree().change_scene_to_file("res://src/levels/level_1/level_1.tscn")

func _on_level2_pressed():
	get_tree().change_scene_to_file("res://src/levels/level_2/level_2.tscn")
	
