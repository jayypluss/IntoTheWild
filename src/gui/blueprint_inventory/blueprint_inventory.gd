extends PanelContainer


const Slot = preload('res://src/gui/slot/slot.tscn')

@onready var blueprint_grid: GridContainer = $MarginContainer/BlueprintGrid

func set_blueprints_inventory_data(blueprint_inventory_data: BlueprintSlotData) -> void:
	populate_item_grid(blueprint_inventory_data.slot_data)

func populate_item_grid(slot_data: Array[BluepintSlotDatum]) -> void:
	for child in blueprint_grid.get_children():
		child.queue_free()
		
	for slot_datum in slot_data:
		var slot = Slot.instantiate()
		blueprint_grid.add_child(slot)
		
		if slot_datum:
			slot.set_slot_datum(slot_datum)
