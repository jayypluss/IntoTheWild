extends Resource
class_name Items

@export var items: Array[Item]

func _init(p_items: Array[Item] = []):
	items = p_items
