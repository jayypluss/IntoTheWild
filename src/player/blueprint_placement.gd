extends RayCast3D


func _ready():
	var blueprint_res = preload('res://src/blueprints/blueprint_material.tres')
	if get_child_count(true) > 0:
		var blueprint = get_child(0)
		if blueprint:
			for child in blueprint.get_children(true):
				if child.is_class('CSGMesh3D'):
					child.material = blueprint_res

func _physics_process(_delta):
	if get_child_count(true) > 0:
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

