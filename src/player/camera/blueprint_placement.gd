extends RayCast3D

var blueprint_res

func _ready():
	blueprint_res = preload('res://src/blueprints/blueprint_material.tres')

func _physics_process(_delta):
	if is_holding_blueprint():
		var blueprint = get_child(0)
		if blueprint:
			var collider = get_collider()
			if !collider:
				blueprint.visible = false
			else:
				blueprint.visible = true
				var collision_point = get_collision_point()
				blueprint.global_position = collision_point
				blueprint.global_rotation = Vector3(0, %CameraPivot/Horizontal.global_rotation.y, 0)
				if Input.is_action_just_pressed('click'):
					place_blueprint()

func set_blueprint_shader():
	if is_holding_blueprint():
		var blueprint = get_child(0)
		if blueprint:
			for child in blueprint.get_children(true):
				if child.is_class('CSGMesh3D'):
					child.material = blueprint_res

func setup_blueprint():
	set_blueprint_shader()

func place_blueprint():
	if is_holding_blueprint():
		var blueprint = get_child(0)
		if blueprint:
			blueprint.reparent(get_tree().current_scene)

func is_holding_blueprint() -> bool:
	return get_child_count(true) > 0
