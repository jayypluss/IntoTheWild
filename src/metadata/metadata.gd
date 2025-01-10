extends Node

@export var items: Items
#@export var blueprints: Blueprints

func _init():
	items = preload('res://src/metadata/items/items.tres')
#	blueprints = preload('res://src/metadata/blueprints/blueprints.tres')
	
