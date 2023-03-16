extends PanelContainer


const Slot = preload('res://src/gui/slot/slot.tscn')

@onready var blueprint_grid: GridContainer = $MarginContainer/BlueprintGrid


func set_blueprints_inventory_data(blueprint_inventory_data: BlueprintSlotData) -> void:
	populate_item_grid(blueprint_inventory_data)

func populate_item_grid(blueprint_inventory_data: BlueprintSlotData) -> void:
	for child in blueprint_grid.get_children():
		child.queue_free()
		
	for slot_datum in blueprint_inventory_data.slot_data:
		var slot = Slot.instantiate()
		blueprint_grid.add_child(slot)
		
		slot.slot_clicked.connect(func(_index, _button, _double_click):
			for child in blueprint_grid.get_children(false):
				child.remove_theme_stylebox_override('panel')
		)
		slot.slot_clicked.connect(blueprint_inventory_data.on_slot_clicked)
		
		if slot_datum:
			slot.set_slot_datum(slot_datum)
