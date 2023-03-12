extends Resource
class_name Blueprint

@export var category: String = ''
@export var mesh: Mesh = null
@export var recipe: Array[Item] = []

func _init(p_category = '', p_mesh = null, p_recipe = []):
	category = p_category
	mesh = p_mesh
	recipe = p_recipe

