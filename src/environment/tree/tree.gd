extends Node3D


@onready var progress_bar = $ProgressBar
@onready var wood_trunk = $WoodTrunk
@onready var bush = $Bush
@onready var timer = $Timer

var is_player_near := false
var chopping_progress := 0.0
var is_broken := false


func _physics_process(_delta: float) -> void:
	if (wood_trunk and wood_trunk.is_player_near
		and !is_broken
		and Game.player.skills.is_skill_selected('chopping_magic')):
			if Input.is_action_pressed('click'):
				progress_bar.visible = true
				increment_value()
				progress_bar.value = chopping_progress
			if Input.is_action_just_released('click'):
				progress_bar.visible = false
			if (chopping_progress >= 100.0):
				break_tree()
		
func increment_value():
	chopping_progress += 1.0
	
func get_chopping_progress():
	return chopping_progress
	
func get_progress_bar():
	return progress_bar

func choose_one_from_array(array: Array[float]) -> float:
	return array[randi() % array.size()]

# Returns one random value that's between -b and -a or  +a and +b. 
func randf_from_two_mirrored_ranges(a: float, b: float) -> float:
	var rand_a = randf_range(a, b)
	var rand_b = randf_range(-b, -a)
	return choose_one_from_array([rand_a, rand_b])

func break_tree():
	bush.freeze = false
	bush.apply_impulse(Vector3(randf_from_two_mirrored_ranges(20, 30), 0, randf_from_two_mirrored_ranges(20, 30)))
	wood_trunk.add_to_group('Holdables')
	wood_trunk.freeze = false
	wood_trunk.apply_impulse(Vector3(randf_from_two_mirrored_ranges(60, 70), 0, randf_from_two_mirrored_ranges(60, 70)))
	wood_trunk.reparent(get_tree().current_scene)
	is_broken = true
	progress_bar.visible = false
	timer.start()
		
func _on_wood_interaction_area_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area and area.is_in_group('PlayerInteractionFields'):
		if !is_broken:
			progress_bar.visible = false


func _on_timer_timeout():
	var items_data = { 'Leaf': { 'quantity': randi_range(2, 3) } }
	for item_datum in items_data.keys():
		for idx in range(items_data[item_datum].quantity):
			var item_instance = preload('res://src/item/item.tscn').instantiate()
			item_instance.title = item_datum
			var path = 'res://assets/3d_meshes/items/' + item_datum.to_lower() + '.tres'
			item_instance.variable_mesh = load(path)
			get_tree().current_scene.add_child(item_instance)
			item_instance.global_position = bush.global_position
	bush.queue_free()
	clean()
	
func clean():
	progress_bar.queue_free()
	timer.queue_free()
