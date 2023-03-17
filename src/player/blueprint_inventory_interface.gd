extends Control
class_name BlueprintsManagement


signal chose_blueprint()

@onready var player: Player
@onready var blueprint_inventory: PanelContainer = $BlueprintsInventory

var blueprint_mode:= false


func _ready():
	player = self.owner

func set_player_blueprints_inventory_data(blueprint_inventory_data: BlueprintSlotData) -> void:
	blueprint_inventory_data.inventory_interact.connect(on_inventory_interact)
	blueprint_inventory.set_blueprints_inventory_data(blueprint_inventory_data)

func on_inventory_interact(blueprint_inventory_data: BlueprintSlotData,
		index: int, _button: int, double_click: bool) -> void:
	var clicked_slot = blueprint_inventory_data.slot_data[index]
	if clicked_slot and double_click:
		await get_tree().create_timer(0.05).timeout
		hold_blueprint(clicked_slot.item_data)

func enter_just_pressed():
	if blueprint_mode:
		var all_selected = player.hud.blueprints_list.get_selected_items()
		player.hud.close()
		if all_selected and all_selected.size() > 0:
			hold_blueprint(all_selected[0])

func hold_blueprint(blueprint: Blueprint):
	if !player.placement_ray.is_holding_blueprint():
		var node = blueprint.body_scene
		var instance = node.instantiate()
		instance.visible = false
		player.placement_ray.add_child(instance)
		player.placement_ray.setup_blueprint()
		chose_blueprint.emit()
		close()

func place_blueprint():
	player.placement_ray.call_deferred('place_blueprint')

func close():
	set_blueprints_inventory_visibility(false)
	blueprint_mode = false

func toggle_blueprint_visibility() -> bool:
	set_blueprints_inventory_visibility(!blueprint_inventory.visible)
	return blueprint_inventory.visible

func set_blueprints_inventory_visibility(new_value: bool):
	blueprint_inventory.visible = new_value
	blueprint_mode = blueprint_inventory.visible
	if blueprint_mode:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
