extends KinematicBody2D

var delay = 0
var coll_obj

func _fixed_process(delta):
    if ( Input.is_action_pressed("ui_left")):
        move(Vector2(-5, 0))
    if ( Input.is_action_pressed("ui_right")):
        move(Vector2(5, 0))
    if delay < 15:
        get_node("Sprite").set_modulate(Color("ffffff"))
    if delay > 0:
        delay -= 1
    if delay == 0:
        set_layer_mask_bit(2, true)





func _ready():
    set_fixed_process(true)


func _on_bullet_body_enter( body ):
    if ( delay == 0 ):
        body.get_node("Sprite").set_modulate(Color("ff0000"))
        set_layer_mask_bit(2, false)
        delay = 60

#func _on_bullet_body_exit( body ):
#    print( "exited: ", body )
#    body.get_node("Sprite").set_modulate(Color("ffffff"))


