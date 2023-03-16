extends Resource
class_name BlueprintSlotData

signal inventory_interact(blueprint_inventory_data: BlueprintSlotData, index: int, button: int, double_click: bool)

@export var slot_data: Array[BluepintSlotDatum]

func on_slot_clicked(index: int, button: int, double_click: bool) -> void:
	inventory_interact.emit(self, index, button, double_click)
