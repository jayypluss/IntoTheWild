@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %Camera3D
@onready var hud: Control = $HUD

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

func pick_item(item: Node3D):
#	item.reparent($CameraPivot/Horizontal/Vertical/RightArm/HoldingItem)
	item.call_deferred("reparent", $CameraPivot/Horizontal/Vertical/RightArm/HoldingItem)
	item.global_transform = $CameraPivot/Horizontal/Vertical/RightArm/HoldingItem.global_transform
	item.rotation_degrees.x = -90
	item.set_freeze_enabled(true)

func is_skill_selected(skill):
	return $PlayerSkills.selected_skill == skill

func select_skill(skill):
	return $PlayerSkills.set_selected_skill(skill)

func obtain_item(item_node: Node3D):
	hud.add_item_to_inventory(item_node)
	print('TO BE IMPLEMENTED - obtaining item: ', item_node.name)
