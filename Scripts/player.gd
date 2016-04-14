extends KinematicBody2D

var MOVE_SPEED = 200.0
var GRAVITY = 500.0

var left = false
var animation_ctr = 0 
var velocity = Vector2()
var motion = Vector2()

func _fixed_process(delta):
	_move_player(delta)

func _ready():
	# Initially sets all spritest to hidden
	get_node("Sprite_Left").set_hidden(true)
	get_node("Sprite_Right").set_hidden(false)
	get_node("Run_Left").set_hidden(true)
	get_node("Run_Right").set_hidden(true)
	set_fixed_process(true)


func _move_player(delta):
	get_node("Sprite_Left").set_hidden(true)
	get_node("Sprite_Right").set_hidden(true)
	get_node("Run_Left").set_hidden(true)
	get_node("Run_Right").set_hidden(true)
	velocity.y += delta * GRAVITY
	motion = velocity * delta
	motion = move(motion)
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		if ( Input.is_action_pressed("ui_up")):
			velocity.y = -300
		if ( Input.is_action_pressed("ui_left")):
			left = true
			animation_ctr += .2
			velocity.x = -MOVE_SPEED
			get_node("Run_Left").set_hidden(false)
			get_node("Run_Left").set_frame(int(animation_ctr) % 4)
		elif ( Input.is_action_pressed("ui_right")):
			left = false
			animation_ctr += .2
			velocity.x = MOVE_SPEED
			get_node("Run_Right").set_hidden(false)
			get_node("Run_Right").set_frame(int(animation_ctr) % 4)
		else:
			animation_ctr = 0
			velocity.x = 0
			get_node("Sprite_Left").set_hidden(not left)
			get_node("Sprite_Right").set_hidden(left)
	else:
		if ( Input.is_action_pressed("ui_left")):
			left = true
			velocity.x -= MOVE_SPEED * 0.01
			get_node("Run_Left").set_hidden(false)
		elif ( Input.is_action_pressed("ui_right")):
			left = false
			velocity.x += MOVE_SPEED * 0.01
			get_node("Run_Right").set_hidden(false)
		else:
			animation_ctr = 0
			get_node("Sprite_Left").set_hidden(not left)
			get_node("Sprite_Right").set_hidden(left)







