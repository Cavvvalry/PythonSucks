extends KinematicBody2D

var MOVE_SPEED = 5.0
var GRAVITY = 5.0

var coll_obj
var left = false
var animation_ctr = 0 
var delay = 0

func _fixed_process(delta):
	_move_player(delta)

func _ready():
	# Initially sets all spritest to hidden
	get_node("Sprite_Left").set_hidden(true)
	get_node("Sprite_Right").set_hidden(false)
	get_node("Run_Left").set_hidden(true)
	get_node("Run_Right").set_hidden(true)
	set_fixed_process(true)

func _on_bullet_body_enter( body ):
	if ( delay == 0 ):
		body.get_node("Sprite").set_modulate(Color("ff0000"))
		set_layer_mask_bit(2, false)
		delay = 60

func _move_player(delta):
	get_node("Sprite_Left").set_hidden(true)
	get_node("Sprite_Right").set_hidden(true)
	get_node("Run_Left").set_hidden(true)
	get_node("Run_Right").set_hidden(true)
	if ( Input.is_action_pressed("ui_left")):
		animation_ctr += .2
		move(Vector2(-MOVE_SPEED, 0))
		get_node("Run_Left").set_hidden(false)
		get_node("Run_Left").set_frame(int(animation_ctr) % 4)
	elif ( Input.is_action_pressed("ui_right")):
		animation_ctr += .2
		move(Vector2(MOVE_SPEED, 0))
		get_node("Run_Right").set_hidden(false)
		get_node("Run_Right").set_frame(int(animation_ctr) % 4)
	else:
		animation_ctr = 0
		get_node("Sprite_Left").set_hidden(left)
		get_node("Sprite_Right").set_hidden(not left)
	move(Vector2(0, GRAVITY))


#func _on_bullet_body_exit( body ):
#    print( "exited: ", body )
#    body.get_node("Sprite").set_modulate(Color("ffffff"))


