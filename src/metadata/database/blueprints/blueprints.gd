extends Resource
class_name Blueprints

signal inventory_interact(blueprints: Blueprints, index: int, button: int, double_click: bool)

@export var blueprints: Array[Blueprint]

func on_slot_clicked(index: int, button: int, double_click: bool) -> void:
	inventory_interact.emit(self, index, button, double_click)
