extends Node3D

var is_player_near := false
var value := 0.0
var is_broken := false

func _physics_process(delta: float) -> void:
	if !is_broken:
		if is_player_near and GameState.player.is_skill_selected('chopping_magic'):
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
	$TopHalf.apply_impulse(Vector3(0, 0, -5))
	is_broken = true
	$ProgressBar.visible = false
	$Timer.start()
		
func _on_area_3d_body_entered(body):
	if body == GameState.player:
		is_player_near = true

func _on_area_3d_body_exited(body):
	if body == GameState.player:
		is_player_near = false
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
