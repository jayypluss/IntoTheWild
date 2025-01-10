extends ItemList

var shortcuts_allocation := ['chopping_magic', '', '', '', '', '', '', '', '', '']
@export var shortcuts: Array[SelectableItemShortcut]

func _ready():
	for i in shortcuts_allocation.size():
		set_item_text(i, shortcuts_allocation[i])

	for i in shortcuts.size():
		set_item_metadata(i, shortcuts[i])

	select_item(0)

func _process(_delta):
	if Input.is_action_just_pressed('0'):
		select_item(9)
	for i in range(1, 10):
		if Input.is_action_just_pressed(str(i)):
			select_item(i-1)

func select_item(idx: int):
	select(idx)
	if Game.player:
		Game.player.skills.set_selected_skill(shortcuts_allocation[idx])
