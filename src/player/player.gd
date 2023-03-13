@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %PlayerCam
@onready var hud: Control = %PlayerHUD
@onready var hand: Node3D = $CameraPivot/Horizontal/Vertical/PlayerHand
@onready var skills: Node = $PlayerSkills
@onready var blueprint_placement: RayCast3D = %CameraPivot/Horizontal/Vertical/BlueprintPlacement

var last_floor_position: Vector3
var blueprint_mode:= false

		
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

func toggle_blueprint_mode():
	blueprint_mode = hud.toggle_blueprint_mode()

func hold_blueprint(index: int):
	if !blueprint_placement.is_holding_blueprint():
		var blueprint_title = %PlayerHUD/BlueprintsList.get_item_text(index)
		var node = load('res://src/blueprints/' + blueprint_title.to_lower() + '/' + blueprint_title + '.tscn')
		var instance = node.instantiate()
		blueprint_placement.add_child(instance)
		blueprint_placement.setup_blueprint()

func place_blueprint():
	blueprint_placement.call_deferred('place_blueprint')
