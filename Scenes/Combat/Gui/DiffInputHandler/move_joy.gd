extends Node2D

@onready var card_sel = get_parent().get_parent().get_node("CardSelected")



var area_input
var button_input

var dir
var norm_dir= Vector2(0,0)
var length

var dragging = false

var max_len = 200

var marker

var marker_speed = 0.02


func _process(delta):
	#print(area_input)
	if dragging:
		card_sel["process_mode"] = Node.PROCESS_MODE_DISABLED
	else:
		card_sel["process_mode"] = Node.PROCESS_MODE_INHERIT

func _physics_process(delta):
	if norm_dir:
		marker.global_position += norm_dir * length * marker_speed
	else:
		marker.global_position += Vector2(0,0)
		

func _input(event):
	if event is InputEventScreenDrag:
		if area_input:
			$Joy.global_position = event.position
			dir = $Joy.global_position - self.global_position
			norm_dir = dir.normalized()
			length = ($Joy.global_position - self.global_position).length()
			
			if length >= max_len:
				$Joy.global_position = self.global_position + norm_dir *max_len
				length = max_len
				
			dragging = true
			
		elif dragging:
			$Joy.global_position = event.position
			dir = $Joy.global_position - self.global_position
			norm_dir = dir.normalized()
			length = ($Joy.global_position - self.global_position).length()
			
			if length >= max_len:
				$Joy.global_position = self.global_position + norm_dir * max_len
				length = max_len
				
			dragging = true
			
			
			#TODO to change later, it more of rotat
	elif event is InputEventScreenTouch:
		if dragging and not event.pressed:
			norm_dir = Vector2(0,0)
			length = 0
			dragging = false
			$Joy.global_position = self.global_position
			
		elif not dragging:
			if button_input and not event.pressed:
				pass
	
	area_input = false
	button_input = false




func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true


func _on_button_area_input_event(viewport, event, shape_idx):
	button_input = true
