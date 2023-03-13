extends Node

@export var types: Resource
@export var items: Items
@export var blueprints: Blueprints

func _init():
	types = preload('res://src/metadata/types/types.tres')
	items = preload('res://src/metadata/items/items.tres')
	blueprints = preload('res://src/metadata/blueprints/blueprints.tres')
	
