extends Area3D

@onready var collision_shape: CollisionShape3D = $Collision
@export var area_radius:= 5.0 : get = get_radius, set = set_radius
var is_player_inside:= false

func _ready():
	set_radius(area_radius)

func _physics_process(_delta):	
	if is_player_inside:
		if Game.player.hand.is_holding_something():
			if Input.is_action_just_pressed('deposit'):
				print('Game.player.hand.holding_item: ', Game.player.hand.holding_item)
				get_viewport().set_input_as_handled()
			if Input.is_action_just_pressed('interact'):
				print('Game.player.hand.holding_item: ', Game.player.hand.holding_item)
				get_viewport().set_input_as_handled()

func _on_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	is_player_inside = true

func _on_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	is_player_inside = false

func set_radius(_radius: float):
	area_radius = _radius
	collision_shape.shape.radius = area_radius

func get_radius():
	return area_radius
