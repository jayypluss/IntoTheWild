extends Node3D

var is_player_near := false
var value := 0.0
var is_broken := false

func _physics_process(delta: float) -> void:
	if !is_broken:	
		if is_player_near:
			if Input.is_action_pressed('click'):
				$ProgressBar.visible = true
				value += 1.0
				$ProgressBar.value = value
			if Input.is_action_just_released('click'):
				$ProgressBar.visible = false
			if (value >= 100.0):
				break_tree()
		
func break_tree():
	print('Breaking tree')
	$Bush.apply_impulse(Vector3(0, 0, 5))
	$TopHalf.apply_impulse(Vector3(0, 0, -5))
	is_broken = true
	$ProgressBar.visible = false
		
func _on_area_3d_body_entered(body):
	if body == GameState.player:
		is_player_near = true


func _on_area_3d_body_exited(body):
	if body == GameState.player:
		is_player_near = false

