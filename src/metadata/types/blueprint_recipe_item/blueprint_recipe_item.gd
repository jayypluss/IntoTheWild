extends Resource
class_name BlueprintRecipeItem


@export var name:= ''
@export var quantity:= 0
@export var associated_node_name:= ''


func _init(p_name = '',
	p_quantity = 0,
	p_associated_node_name = ''):
		name = p_name
		quantity = p_quantity
		associated_node_name = p_associated_node_name
