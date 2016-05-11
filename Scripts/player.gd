extends KinematicBody2D

var MOVE_SPEED = 175.0
var GRAVITY = 500.0

var left = false
var animation_ctr = 0 
var velocity = Vector2()
var motion = Vector2()
var health = 100
var countdown = 120
var score = 0
var jmp_detect = 0 
var n = Vector2()
var delay = 0
var shot_delay = 0
var gun_dir = 0
var baselaser = preload("res://Character Sprite/laser.xml")
var baseslime = preload("res://Enemy Sprite/slime.xml")

func _fixed_process(delta):
	get_node("HUD ParaBKG/HUD ParaLYR/Score").set_text(str(score))
	get_node("HUD ParaBKG/HUD ParaLYR/Health2").set_value(health)
	if health <= 0:
		death()
	else:
		velocity.y += delta * GRAVITY
		motion = velocity * delta
		_move_player(delta)
		if shot_delay > 0:
			shot_delay -= 1
		if (Input.is_action_pressed("ui_shoot") and shot_delay == 0):
			fire_laser()
			shot_delay = 30
		if delay < 15:
			get_node("hitLight").set_enabled(false)
		if delay > 0:
			delay -= 1
		if delay == 0:
			set_layer_mask_bit(2, true)
		if ( Input.is_action_pressed("ui_up")):
			gun_dir = PI/2
			if left:
				get_node("gun").set_rot(-PI/2)
			else:
				get_node("gun").set_rot(PI/2)
		else:
			get_node("gun").set_rot(0)
			gun_dir = left * PI
		get_node("gun").set_flip_h(left)
		if (Input.is_action_pressed("ui_focus_next")):
			spawn_death()



func _ready():
	# Initially sets all spritest to hidden
	get_node("Sprite_Left").set_hidden(true)
	get_node("Sprite_Right").set_hidden(false)
	get_node("Run_Left").set_hidden(true)
	get_node("Run_Right").set_hidden(true)
	set_fixed_process(true)


func _move_player(delta):
	if is_colliding():
		jmp_detect = 0
		n = get_collision_normal()
		motion = n.slide(motion)
		if n.x != 0 and n.y < -0.5: #Ramp walking speedup
			motion *= 2
		move(motion)
		velocity = n.slide(velocity)
		if n.y < -0.5:
			velocity.y = 0 #Player ramping prevention
			if ( Input.is_action_pressed("ui_accept")):
				velocity.y = -300
				score += 1
		if ( Input.is_action_pressed("ui_left")):
			left = true
			animation_ctr += .3
			velocity.x = -MOVE_SPEED
			get_node("Sprite_Left").set_hidden(true)
			get_node("Sprite_Right").set_hidden(true)
			get_node("Run_Right").set_hidden(true)
			get_node("Run_Left").set_hidden(false)
			get_node("Run_Left").set_frame(int(animation_ctr) % 4)
		elif ( Input.is_action_pressed("ui_right")):
			left = false
			animation_ctr += .3
			velocity.x = MOVE_SPEED
			get_node("Sprite_Left").set_hidden(true)
			get_node("Sprite_Right").set_hidden(true)
			get_node("Run_Left").set_hidden(true)
			get_node("Run_Right").set_hidden(false)
			get_node("Run_Right").set_frame(int(animation_ctr) % 4)
		else:
			animation_ctr = 0
			velocity.x = 0
			get_node("Run_Left").set_hidden(true)
			get_node("Run_Right").set_hidden(true)
			get_node("Sprite_Left").set_hidden(not left)
			get_node("Sprite_Right").set_hidden(left)

	else:
		move(motion)
		jmp_detect += 1
		if jmp_detect >= 2:
			get_node("Sprite_Left").set_hidden(true)
			get_node("Sprite_Right").set_hidden(true)
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
		if velocity.x > MOVE_SPEED:
			velocity.x = MOVE_SPEED
		if velocity.x < -MOVE_SPEED:
			velocity.x = -MOVE_SPEED

func death():
	countdown -= 1
	get_node("../StreamPlayer").set_volume_db(get_node("../StreamPlayer").get_volume_db() - .5)
	get_node("../Fade").set_color(Color(get_node("../Fade").get_color().r - .05, get_node("../Fade").get_color().g - .05, get_node("../Fade").get_color().b - .05))
	if countdown <= 0:
		get_node("/root/global").setScene("res://Scenes/GameOver.scn")

func fire_laser():
	print("Pew")
	var laser = baselaser.instance()
	get_node("/root/Node2D").add_child(laser)
	laser.set_pos(get_node("gun").get_global_pos())
	laser.set_rot(gun_dir)

func spawn_death():
	print("You messed up")
	var slime = baseslime.instance()
	get_node("/root/Node2D").add_child(slime)
	slime.set_scale(Vector2(4,4))
	slime.set_pos(get_node("gun").get_global_pos() + Vector2(0, -300))




