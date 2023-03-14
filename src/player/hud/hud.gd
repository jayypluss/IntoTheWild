extends Control
class_name PlayerHUD

@onready var inventory: ItemList = $Inventory
@onready var blueprints_list: ItemList = $BlueprintsList
var items: Dictionary = {  }


func _process(_delta):
	if Input.is_action_just_pressed('toggle_inventory'):
		inventory.visible = !inventory.visible

func add_item_to_inventory(item_node: Node3D):
	if items.has(item_node.title):
		items[item_node.title].quantity += 1
		inventory.set_item_text(items[item_node.title].index, (item_node.title + '  x' + str(items[item_node.title].quantity)))
	else:
		var idx = inventory.add_item((item_node.title + '  x1'))
		items.merge( { item_node.title: { 'quantity': 1, 'index': idx } }, false)
	item_node.queue_free()

func close():
	inventory.visible = false
	blueprints_list.visible = false

func toggle_blueprint_mode():
	blueprints_list.visible = !blueprints_list.visible
	if blueprints_list.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	return blueprints_list.visible
