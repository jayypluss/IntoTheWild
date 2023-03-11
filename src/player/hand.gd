extends Node3D


@onready var player_hud = %PlayerHUD

var items_near:= []
var closest_holdable: Node3D
var holding_item: Node3D
var holding_item_pos: String

func _physics_process(_delta):
	if Input.is_action_just_pressed('collect'):
		if items_near.size() > 0:
			for item in items_near:
				if item.is_in_group('Collectables'):
					obtain_item(item)
		elif closest_holdable and !holding_item:
			call_deferred('hold_item', closest_holdable, 'above')
			
	if (Input.is_action_just_pressed('click')
		and get_child_count() > 0
		and get_child(0, true).has_method('trigger1')):
			var throw = get_child(0, true).trigger1()
			if throw:
				holding_item = null
				holding_item_pos = ''
	if (Input.is_action_just_pressed('right_click')
		and get_child_count() > 0
		and get_child(0, true).has_method('trigger2')):
			var throw = get_child(0	, true).trigger2()
			if throw:
				holding_item = null
				holding_item_pos = ''
			
func hold_item(item: Node3D, item_placement: String = 'right'):
	holding_item = item
	holding_item_pos = item_placement
	
	item.reparent(self)
	item.remove_from_group('Holdables')
	if item_placement == 'right':
		position = Vector3(0.11, 0.513, -0.248)
	elif item_placement == 'above':
		position = Vector3(0.7, 1.3, -0.248)
		
	item.global_transform = global_transform
	item.rotation_degrees.x = 90
	
	if item.is_class('PhysicsBody3D'):
		item.set_freeze_enabled(true)
		
	if item.find_child('WoodTrunkCollision'):
		item.find_child('WoodTrunkCollision').call_deferred('set_disabled', true)


func obtain_item(item_node: Node3D):
	var idx = items_near.find(item_node)
	if idx >= 0:
		items_near.remove_at(idx)
	player_hud.add_item_to_inventory(item_node)
	
func _on_interaction_field_area_shape_entered(_area_rid, area: Area3D, _area_shape_index, _local_shape_index):
	if area and area.get_parent():
		var parent = area.get_parent()
		if parent.is_in_group('Collectables'):
			if items_near.find(parent) < 1:
				items_near.append(parent)
		elif parent.is_in_group('Holdables'):
				closest_holdable = parent
	
func _on_interaction_field_area_shape_exited(_area_rid, area: Area3D, _area_shape_index, _local_shape_index):
	if area and area.get_parent():
		var parent = area.get_parent()
		if parent.is_in_group('Collectables'):
			var idx = items_near.find(parent)
			if idx >= 0:
				items_near.remove_at(idx)
		elif (parent.is_in_group('Holdables') 
			and closest_holdable == parent):
				closest_holdable = null
