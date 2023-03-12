extends Node3D



func _ready():
	var tree_node = preload('res://src/environment/tree/tree.tscn')
	for i in range(0, 30):
		var instance = tree_node.instantiate()
		get_tree().current_scene.add_child(instance)
		instance.global_position = Vector3(randf_range(-80, 80), 0, randf_range(-80, 80))
