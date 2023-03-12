@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %PlayerCam
@onready var hud: Control = %PlayerHUD
@onready var hand: Node3D = $CameraPivot/Horizontal/Vertical/PlayerHand
@onready var skills: Node = $PlayerSkills

var last_floor_position: Vector3

func _ready():
	GameState.player = self
	check_everything_is_not_null()

func check_everything_is_not_null():
	if !camera:
		print('camera is null')

func _get_configuration_warnings() -> PackedStringArray:
	if not camera:
		return PackedStringArray(["Missing camera node"])
	else:
		return []

func is_skill_selected(skill):
	return skills.selected_skill == skill

func select_skill(skill):
	return skills.set_selected_skill(skill)
	
func _on_last_position_timer_timeout():
	var last_slide_collision = get_last_slide_collision()
	if (is_on_floor() 
		and last_slide_collision 
		and last_slide_collision.get_collider() 
		and last_slide_collision.get_collider() is CSGMesh3D):
			last_floor_position = position

func die():
	position = last_floor_position
