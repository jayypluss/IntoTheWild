@tool
extends Node3D

@export var mesh: Mesh
@export var title: String


func _ready():
	if $Mesh:
		$Mesh.mesh = mesh
	
func _on_area_3d_body_entered(body):
	GameState.player.obtain_item(self)

