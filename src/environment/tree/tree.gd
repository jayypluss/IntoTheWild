extends Node3D

var is_player_near := false
var value := 0.0
var is_broken := false

func _physics_process(_delta: float) -> void:
	if !is_broken:
		if ($WoodTrunk 
			and $WoodTrunk.is_player_near 
			and GameState.player.is_skill_selected('chopping_magic')):
				if Input.is_action_pressed('click'):
					$ProgressBar.visible = true
					value += 1.0
					$ProgressBar.value = value
				if Input.is_action_just_released('click'):
					$ProgressBar.visible = false
				if (value >= 100.0):
					break_tree()
		
func break_tree():
	$Bush.apply_impulse(Vector3(0, 0, 5))
	$WoodTrunk.is_dettached = true
	$WoodTrunk.apply_impulse(Vector3(0, 0, -5))
	is_broken = true
	$ProgressBar.visible = false
	$Timer.start()
		
func _on_wood_interaction_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group('PlayerInteractionFields'):
		if !is_broken:
			$ProgressBar.visible = false

	
func _on_timer_timeout():
	var items_data = { 'Leaf': { 'quantity': randi_range(2, 3) } }
	for item_datum in items_data.keys():
		for idx in range(items_data[item_datum].quantity):
			var item_instance = preload('res://src/items/item.tscn').instantiate()
			item_instance.title = item_datum
			item_instance.mesh = preload('res://src/items/meshes/leaf_mesh.tres')
			get_tree().current_scene.add_child(item_instance)
			item_instance.global_position = $Bush.global_position
	$Bush.queue_free()
	clean()
	
func clean():
	$ProgressBar.queue_free()
	$Timer.queue_free()
