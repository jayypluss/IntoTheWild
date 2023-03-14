extends CanvasLayer
class_name PlayerHUD

@onready var inventory: ItemList = $Inventory


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

func close_inventory():
	inventory.visible = false

