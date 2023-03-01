extends ItemList


func _ready():
	select(0)

func _process(delta):
	if Input.is_action_just_pressed('0'):
		select(0)
	if Input.is_action_just_pressed('1'):
		select(1)
	if Input.is_action_just_pressed('3'):
		select(3)
	if Input.is_action_just_pressed('4'):
		select(4)
	if Input.is_action_just_pressed('5'):
		select(5)
	if Input.is_action_just_pressed('6'):
		select(6)
	if Input.is_action_just_pressed('7'):
		select(7)
	if Input.is_action_just_pressed('8'):
		select(8)
	if Input.is_action_just_pressed('9'):
		select(9)
