extends Node3D

@onready var is_player_near := false

func _on_interaction_area_body_entered(body):
	is_player_near = true

func _on_interaction_area_body_exited(body):
	is_player_near = false

func _physics_process(delta):
	if is_player_near and Input.is_action_just_pressed('interact'):
		print ('interacted')
		$AnimationPlayer.play('lift')
