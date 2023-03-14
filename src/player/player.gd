@tool
class_name Player
extends CharacterBody3D


@onready var camera: Camera3D = %PlayerCam
@onready var camera_pivot: CameraPivot = %CameraPivot
@onready var hud: PlayerHUD = %PlayerHUD
@onready var hand: PlayerHand = $CameraPivot/Horizontal/Vertical/PlayerHand
@onready var skills: PlayerSkills = $PlayerSkills
@onready var blueprint_placement: PlayerBlueprintPlacement = %CameraPivot/Horizontal/Vertical/BlueprintPlacement
@onready var blueprints_management: BlueprintsManagement = $BlueprintsManagement

var last_floor_position: Vector3


func _ready():
	Game.player = self

func _get_configuration_warnings() -> PackedStringArray:
	if not camera:
		return PackedStringArray(["Missing camera node"])
	else:
		return []

func _on_last_position_timer_timeout():
	var last_slide_collision = get_last_slide_collision()
	if (is_on_floor() 
		and last_slide_collision 
		and last_slide_collision.get_collider() 
		and last_slide_collision.get_collider() is CSGMesh3D):
			last_floor_position = position

func die():
	position = last_floor_position

