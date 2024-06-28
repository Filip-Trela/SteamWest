class_name CustomButton

extends Button

var butt_pressed:bool = false


func _on_button_up():
	if butt_pressed:
		activate()


func _on_button_down():
	butt_pressed = true


func _on_mouse_exited():
	butt_pressed = false

func activate():
	pass
