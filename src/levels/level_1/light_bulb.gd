extends OmniLight3D

@export var should_blink: bool = false
@export var blinking_time_min: float = 3.0
@export var blinking_time_max: float = 7.0

@onready var hide_timer: Timer = $HideTimer
@onready var show_timer: Timer = $ShowTimer
@onready var re_hide_timer: Timer = $ReHideTimer
@onready var re_show_timer: Timer = $ReShowTimer

var will_blink: bool = true

func _ready():
	if should_blink:
		hide_timer.start()

func _on_blinking_timer_timeout():
	if visible:
		hide()
	hide_timer.wait_time = randf_range(blinking_time_min, blinking_time_max)
	show_timer.start()
	will_blink = randi_range(0, 1)

func _on_show_timer_timeout():
	if !visible:
		show()
	if will_blink:
		re_hide_timer.start()

func _on_re_hide_timer_timeout():
	if visible:
		hide()
	if will_blink:
		re_show_timer.start()

func _on_re_show_timer_timeout():
	if !visible:
		show()
