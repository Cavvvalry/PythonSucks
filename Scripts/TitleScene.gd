
extends VBoxContainer

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(Input.is_action_pressed("ui_accept")):
		_on_NewGame_pressed()




func _on_NewGame_pressed():	
	print("TESTing")
	get_node("/root/global").setScene("res://Scenes/Level_1.scn")



func _on_QuitButton_pressed():
	get_tree().quit()



func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		print("ev")	

