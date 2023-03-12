extends Node3D

func _on_area_3d_body_entered(player: Player):
	player.die()
