extends KinematicBody2D

var MOVE_SPEED = 200.0
var GRAVITY = 500.0

var left = false
var animation_ctr = 0 
var velocity = Vector2()
var motion = Vector2()
var health = 100
var score = 0
var jmp_detect = 0 

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
	if velocity.x > MOVE_SPEED:
		velocity.x = MOVE_SPEED
	if velocity.x < -MOVE_SPEED:
		velocity.x = -MOVE_SPEED
	motion = velocity * delta
	get_node("HUD ParaBKG/HUD ParaLYR/Score").set_text(str(score))
	get_node("HUD ParaBKG/HUD ParaLYR/Health").set_value(health)
	get_node("HUD ParaBKG/HUD ParaLYR/Health2").set_value(100 - score)
	print(score)
	
	if is_colliding():
		jmp_detect = 0
	else:
		jmp_detect += 1 
	
	if (jmp_detect < 2):
		var n = get_collision_normal()
		motion = n.slide(motion)
		move(motion)
		velocity = n.slide(velocity)
		if ( Input.is_action_pressed("ui_up")):
			if n.y < 0:
				velocity.y = -300
				score += 1
		if ( Input.is_action_pressed("ui_left")):
			left = true
			animation_ctr += .1
			velocity.x = -MOVE_SPEED
			get_node("Run_Left").set_hidden(false)
			get_node("Run_Left").set_frame(int(animation_ctr) % 4)
		elif ( Input.is_action_pressed("ui_right")):
			left = false
			animation_ctr += .1
			velocity.x = MOVE_SPEED
			get_node("Run_Right").set_hidden(false)
			get_node("Run_Right").set_frame(int(animation_ctr) % 4)
		else:
			animation_ctr = 0
			velocity.x = 0
			get_node("Sprite_Left").set_hidden(not left)
			get_node("Sprite_Right").set_hidden(left)
	else:
		move(motion)
		jmp_detect += 1
		if jmp_detect > 2:
			get_node("Run_Left").set_frame(0)
			get_node("Run_Right").set_frame(0)
			get_node("Run_Left").set_hidden(not left)
			get_node("Run_Right").set_hidden(left)				
		if ( Input.is_action_pressed("ui_left")):
			left = true
			velocity.x -= MOVE_SPEED * 0.1
		elif ( Input.is_action_pressed("ui_right")):
			left = false
			velocity.x += MOVE_SPEED * 0.1






