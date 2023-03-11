extends RigidBody3D

@onready var wood_trunk_collision = $WoodTrunkCollision

var is_player_near:= false

func trigger1() -> bool:
	add_to_group('Holdables')
	reparent(get_tree().current_scene, true)
	wood_trunk_collision.call_deferred('set_disabled', false)
	set_freeze_enabled(false)
	apply_impulse(Vector3(10, 0, 0))
	return true
	
func _on_wood_interaction_area_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area and area.is_in_group('PlayerInteractionFields'):
		is_player_near = true

func _on_wood_interaction_area_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area and area.is_in_group('PlayerInteractionFields'):
		is_player_near = false
