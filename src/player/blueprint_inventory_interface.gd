extends Control
class_name BlueprintsManagement

@onready var player: Player
@onready var blueprint_inventory: PanelContainer = $BlueprintInventory

var blueprint_mode:= false


func _ready():
	player = self.owner

func set_player_blueprints_inventory_data(blueprint_inventory_data: BlueprintSlotData) -> void:
	blueprint_inventory.set_blueprints_inventory_data(blueprint_inventory_data)

func enter_just_pressed():
	if blueprint_mode:
		var all_selected = player.hud.blueprints_list.get_selected_items()
		player.hud.close()
		if all_selected and all_selected.size() > 0:
			hold_blueprint(all_selected[0])

func hold_blueprint(index: int):
	if !player.placement_ray.is_holding_blueprint():
		var blueprint_title = player.hud.blueprints_list.get_item_text(index)
		var node = load('res://src/blueprints/' + blueprint_title.to_lower() + '/' + blueprint_title.to_lower() + '.tscn')
		var instance = node.instantiate()
		player.placement_ray.add_child(instance)
		player.placement_ray.setup_blueprint()

func place_blueprint():
	player.placement_ray.call_deferred('place_blueprint')

func close():
	blueprint_inventory.visible = false

func toggle_blueprint_mode() -> bool:
	blueprint_inventory.visible = !blueprint_inventory.visible
	return blueprint_inventory.visible
