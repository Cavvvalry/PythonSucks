
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass




func _on_NewGame_pressed():	
	print("TESTing")
	get_node("/root/global").setScene("res://Scenes/Level_1.scn")
	pass # replace with function body


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # replace with function body


func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		print("ev")	
	
