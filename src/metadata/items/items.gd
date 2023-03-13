extends Resource
class_name Items

@export var leaf: Item = null
@export var wood_trunk: Item = null

func _init(p_leaf = null):
	leaf = p_leaf
	
