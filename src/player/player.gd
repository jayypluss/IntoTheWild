@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %Camera3D
@onready var hud: Control = $HUD
@onready var hand: Node3D = $CameraPivot/Horizontal/Vertical/Hand

var both_hands_busy := false

var items_near:= []
var closest_holdable: Node3D

func _physics_process(_delta):
	if Input.is_action_just_pressed('collect'):
		if items_near.size() > 0:
			for i in items_near.size():
				if items_near[i].is_in_group('Collectable'):
					obtain_item(items_near[i])
					items_near.remove_at(i)
		elif closest_holdable:
			hold_item(closest_holdable, 'above')
			
#	print('closest_holdable: ', closest_holdable)
		
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

func hold_item(item: Node3D, item_placement: String = 'right'):
	hand.hold_item(item, item_placement)

func is_skill_selected(skill):
	return $PlayerSkills.selected_skill == skill

func select_skill(skill):
	return $PlayerSkills.set_selected_skill(skill)

func obtain_item(item_node: Node3D):
	hud.add_item_to_inventory(item_node)
	print('TO BE IMPLEMENTED - obtaining item: ', item_node.name)

func _on_interaction_field_area_shape_entered(area_rid, area: Area3D, area_shape_index, local_shape_index):
	print('area: ', area)
	if area and area.get_parent():
		print('area.get_parent(): ', area.get_parent())
		if area.get_parent().is_in_group('Collectable'):
			var idx = items_near.find(area.get_parent())
			items_near.remove_at(idx)
		elif (area.get_parent().is_in_group('Holdable') 
			and closest_holdable == area.get_parent()):
				closest_holdable = null
	
	

func _on_interaction_field_area_shape_exited(area_rid, area: Area3D, area_shape_index, local_shape_index):
	print('area: ', area)
	if area and area.get_parent():
		print('area.get_parent(): ', area.get_parent())
		if area.get_parent().is_in_group('Collectable'):
			var idx = items_near.find(area.get_parent())
			items_near.remove_at(idx)
		elif (area.get_parent().is_in_group('Holdable') 
			and closest_holdable == area.get_parent()):
				closest_holdable = null
