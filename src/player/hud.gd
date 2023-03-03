extends Control

@onready var inventory: ItemList = $Inventory
var items: Dictionary = {  }


func _process(delta):
	if Input.is_action_just_pressed('I'):
		inventory.visible = !inventory.visible

func add_item_to_inventory(item_node: Node3D):
	if items.has(item_node.title):
		items[item_node.title].quantity += 1
		inventory.set_item_text(items[item_node.title].index, (item_node.title + '  x' + str(items[item_node.title].quantity)))
	else:
		var idx = inventory.add_item((item_node.title + '  x1'))
		items.merge( { item_node.title: { 'quantity': 1, 'index': idx } }, false)
	print(items)
	item_node.queue_free()
