extends Node3D

@onready var holding_item = $HoldingItem


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed('click') 
		&& holding_item && holding_item.get_child_count() > 0
		&& holding_item.get_child(0, true).has_method('trigger1')):
			holding_item.get_child(0, true).trigger1()
	if (Input.is_action_just_pressed('right_click') 
		&& holding_item && holding_item.get_child_count() > 0
		&& holding_item.get_child(0, true).has_method('trigger2')):
			holding_item.get_child(0, true).trigger2()
