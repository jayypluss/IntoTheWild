@tool
class_name Player
extends CharacterBody3D


@onready var camera: Camera3D = %PlayerCam
@onready var input: Node = $Input
@onready var camera_pivot: CameraPivot = %CameraPivot
@onready var hud: PlayerHUD = %PlayerHUD
@onready var hand: PlayerHand = $CameraPivot/Horizontal/Vertical/PlayerHand
@onready var skills: PlayerSkills = $PlayerSkills
@onready var placement_ray: PlayerPlacementRay = %CameraPivot/Horizontal/Vertical/PlayerPlacementRay
@onready var blueprint_inventory_interface = $PlayerHUD/BlueprintInventoryInterface

@export var blueprint_data: BlueprintSlotData

var last_floor_position:= Vector3(0, 2, 0)


func _ready():
	Game.player = self
	blueprint_inventory_interface.set_player_blueprints_inventory_data(blueprint_data)
	blueprint_inventory_interface.chose_blueprint.connect(func():
		input.paused = false
		camera_pivot.paused = false
	)

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
		and (last_slide_collision.get_collider() is CSGMesh3D
		or last_slide_collision.get_collider().is_in_group('Floors'))):
			last_floor_position = position

func die():
	position = last_floor_position

