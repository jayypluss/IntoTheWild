extends Resource

@export var item: Resource

func _init():
	item = preload('res://src/metadata/types/item/item.tres')
