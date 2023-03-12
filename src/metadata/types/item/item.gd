extends Resource
class_name Item

@export var type: String = ''
@export var mesh: Mesh = null
@export var icon: Image = null

func _init(p_type = '', p_mesh = null, p_icon = null):
	type = p_type
	mesh = p_mesh
	icon = p_icon
	
