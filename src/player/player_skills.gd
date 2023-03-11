extends Node

@onready var camera: Camera3D = %PlayerCam
@onready var particles_emitter: GPUParticles3D = %CameraPivot/Horizontal/Vertical/PlayerEmitter
@onready var hand: Node3D = %CameraPivot/Horizontal/Vertical/PlayerHand

var owned_skills := ['chopping_magic']
var selected_skill := 'chopping_magic'
var is_casting_magic := false

func _process(_delta):
	if (Input.is_action_pressed('click') 
		and !hand.holding_item 
		and selected_skill):
		is_casting_magic = true
	else:
		is_casting_magic = false
				
	if particles_emitter:
		particles_emitter.emitting = is_casting_magic
	

func set_selected_skill(skill_id: String):
	selected_skill = skill_id
