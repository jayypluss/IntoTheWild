extends Node3D

var is_holding_something:= false
var both_hands_busy := false

var items_near:= []
var closest_holdable: Node3D

func _process(_delta):
	if Input.is_action_just_pressed('collect'):
		if items_near.size() > 0:
			for i in items_near.size():
				if items_near[i].is_in_group('Collectable'):
					obtain_item(items_near[i])
					items_near.remove_at(i)
		elif closest_holdable:
			hold_item(closest_holdable, 'above')
			
	if (Input.is_action_just_pressed('click') 
		and get_child_count() > 0 
		and get_child(0, true).has_method('trigger1')):
			get_child(0, true).trigger1()
	if (Input.is_action_just_pressed('right_click') 
		and get_child_count() > 0 
		and get_child(0, true).has_method('trigger2')):
			get_child(0, true).trigger2()
			
func hold_item(item: Node3D, item_placement: String = 'right'):
	item.remove_from_group('Holdables')
	item.print_tree_pretty()
	if item_placement == 'right':
		position = Vector3(0.11, 0.513, -0.248)
	elif item_placement == 'above':
		position = Vector3(0.7, 1.3, -0.248)

	item.call_deferred('reparent', self)
	is_holding_something = true
	item.global_transform = global_transform
	item.rotation_degrees.x = 90
	if item.find_child('CollisionShape3D'):
		item.find_child('CollisionShape3D').call_deferred('set_disabled', true)
	item.set_freeze_enabled(true)

func obtain_item(item_node: Node3D):
	%hud.add_item_to_inventory(item_node)
	print('TO BE IMPLEMENTED - obtaining item: ', item_node.name)
	
func _on_interaction_field_area_shape_entered(area_rid, area: Area3D, area_shape_index, local_shape_index):
	if area and area.get_parent():
		var parent = area.get_parent()
		print('got near ', parent)
		print('groups it has: ', parent.get_groups())
		if parent.is_in_group('Collectables'):
			if items_near.find(parent) < 1:
				items_near.append(parent)
		elif parent.is_in_group('Holdables'):
				closest_holdable = parent
				
	print('items_near: ', items_near)
	print('closest_holdable: ', closest_holdable)
	
func _on_interaction_field_area_shape_exited(area_rid, area: Area3D, area_shape_index, local_shape_index):
	if area and area.get_parent():
		var parent = area.get_parent()
		print('got far from ', parent)
		print('groups it has: ', parent.get_groups())
		if area.get_parent().is_in_group('Collectables'):
			var idx = items_near.find(area.get_parent())
			items_near.remove_at(idx)
		elif (area.get_parent().is_in_group('Holdables') 
			and closest_holdable == area.get_parent()):
				closest_holdable = null

	print('items_near: ', items_near)
	print('closest_holdable: ', closest_holdable)