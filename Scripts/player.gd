extends KinematicBody2D

var MOVE_SPEED = 5.0
var GRAVITY = 5.0

var delay = 0
var coll_obj

func _fixed_process(delta):
    if ( Input.is_action_pressed("ui_left")):
        move(Vector2(-MOVE_SPEED, 0))
        if get_node("Sprite_Left").is_hidden() == true:
            get_node("Sprite_Left").set_hidden(false)
            get_node("Sprite_Right").set_hidden(true)
    if ( Input.is_action_pressed("ui_right")):
        move(Vector2(MOVE_SPEED, 0))
        if get_node("Sprite_Left").is_hidden() == false:
            get_node("Sprite_Left").set_hidden(true)
            get_node("Sprite_Right").set_hidden(false)
    if delay < 15:
        move(Vector2(0, GRAVITY))
    if delay > 0:
        delay -= 1
    if delay == 0:
        set_layer_mask_bit(2, true)

func _ready():
    get_node("Sprite_Left").set_hidden(true)
    get_node("Sprite_Right").set_hidden(false)
    set_fixed_process(true)

func _on_bullet_body_enter( body ):
    if ( delay == 0 ):
        body.get_node("Sprite").set_modulate(Color("ff0000"))
        set_layer_mask_bit(2, false)
        delay = 60

#func _on_bullet_body_exit( body ):
#    print( "exited: ", body )
#    body.get_node("Sprite").set_modulate(Color("ffffff"))


