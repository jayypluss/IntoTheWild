extends Node

var items: Items
var blueprints: Blueprints

func _init():
	items = preload('res://src/metadata/database/items/items.tres')
	blueprints = preload('res://src/metadata/database/blueprints/blueprints.tres')
