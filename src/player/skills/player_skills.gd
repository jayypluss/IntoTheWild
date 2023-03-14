extends Node

@onready var camera: Camera3D = %PlayerCam
@onready var particles_emitter: GPUParticles3D = %CameraPivot/Horizontal/Vertical/PlayerEmitter
@onready var hand: Node3D = %CameraPivot/Horizontal/Vertical/PlayerHand

var owned_skills := ['chopping_magic']
var selected_skill := 'chopping_magic'
var is_casting_magic := false


func set_selected_skill(skill_id: String):
	selected_skill = skill_id

func is_skill_selected(skill):
	return selected_skill == skill

func click():
	if (!hand.holding_item 
		and selected_skill):
			is_casting_magic = true
	else:
		is_casting_magic = false
				
	if particles_emitter:
		particles_emitter.emitting = is_casting_magic
	
func release():
	is_casting_magic = false
	if particles_emitter:
		particles_emitter.emitting = is_casting_magic
