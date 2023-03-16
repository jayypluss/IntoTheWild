extends Node
class_name BlueprintsManagement

@onready var player: Player

var blueprint_mode:= false


func _ready():
	player = self.owner

func enter_just_pressed():
	if blueprint_mode:
		var all_selected = player.hud.blueprints_list.get_selected_items()
		player.hud.close()
		if all_selected and all_selected.size() > 0:
			hold_blueprint(all_selected[0])

func toggle_blueprint_mode():
	blueprint_mode = player.blueprint_inventory_control.toggle_blueprint_mode()

func hold_blueprint(index: int):
	if !player.placement_ray.is_holding_blueprint():
		var blueprint_title = player.hud.blueprints_list.get_item_text(index)
		var node = load('res://src/blueprints/' + blueprint_title.to_lower() + '/' + blueprint_title.to_lower() + '.tscn')
		var instance = node.instantiate()
		player.placement_ray.add_child(instance)
		player.placement_ray.setup_blueprint()

func place_blueprint():
	player.placement_ray.call_deferred('place_blueprint')
