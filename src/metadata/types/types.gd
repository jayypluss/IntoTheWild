extends Resource

@export var item: Resource = null

func _init():
	item = preload('res://src/metadata/types/item/item.tres')
