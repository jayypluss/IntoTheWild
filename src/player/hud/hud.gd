extends Control
class_name PlayerHUD

@onready var blueprints_inventory_control: Control = $BlueprintsInventoryControl
@onready var inventory_control: Control = $ItemsInventoryControl

var items: Dictionary = {  }

func _process(_delta):
	if Input.is_action_just_pressed('toggle_inventory'):
		inventory_control.toggle_visible()

func add_item_to_inventory(item_node: Node3D):
	if items.has(item_node.title):
		items[item_node.title].quantity += 1
		inventory_control.set_inventory_item_text(items[item_node.title].index, (item_node.title + '  x' + str(items[item_node.title].quantity)))
	else:
		var idx = inventory_control.add_item((item_node.title + '  x1'))
		items.merge( { item_node.title: { 'quantity': 1, 'index': idx } }, false)
	item_node.queue_free()

func close_hud_windows():
	inventory_control.set_inventory_visibility(false)
	blueprints_inventory_control.set_blueprints_inventory_visibility(false)
