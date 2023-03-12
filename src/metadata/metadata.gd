extends Node

@export var types: Resource
@export var items: Resource

func _init():
	types = preload('res://src/metadata/types/types.tres')
	items = preload('res://src/metadata/items/items.tres')
	
