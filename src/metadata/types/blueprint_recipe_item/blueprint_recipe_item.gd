extends Resource
class_name BlueprintRecipeItem


@export var name:= ''
@export var quantity:= 0
@export var associated_mesh_nodes:= ['']


func _init(p_name = '',
	p_quantity = 0):
		name = p_name
		quantity = p_quantity
