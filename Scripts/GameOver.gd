
extends Node

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		_on_Button_pressed()



func _on_Button_pressed():
	get_node("/root/global").setScene("res://Scenes/TitleScene.scn")


