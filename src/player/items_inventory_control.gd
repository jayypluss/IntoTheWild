extends Control


@onready var items_inventory = $ItemsInventory


func toggle_visible():
	set_inventory_visibility(!items_inventory.visible)
	
func set_inventory_visibility(new_value: bool):
	items_inventory.visible = new_value
	mouse_filter = Control.MOUSE_FILTER_STOP if items_inventory.visible else Control.MOUSE_FILTER_IGNORE

func set_inventory_item_text(item_index: int, new_text: String):
	items_inventory.set_item_text(item_index, new_text)

func add_item(new_item_text: String):
	return items_inventory.add_item(new_item_text)

func close():
	set_inventory_visibility(false)
