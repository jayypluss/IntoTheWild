extends Node3D

var is_holding_something:= false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed('click') 
		and get_child_count() > 0 
		and get_child(0, true).has_method('trigger1')):
			get_child(0, true).trigger1()
	if (Input.is_action_just_pressed('right_click') 
		and get_child_count() > 0 
		and get_child(0, true).has_method('trigger2')):
			get_child(0, true).trigger2()
			
func hold_item(item: Node3D, item_placement: String = 'right'):
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
