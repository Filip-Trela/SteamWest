extends Node2D

@onready var card_sel = get_parent().get_parent().get_node("CardSelected")
@onready var card_handler = get_parent().get_parent().get_node("CardHandler")
@onready var comb_world = get_parent().get_parent().get_parent().get_node("CombatWorld")
@onready var deck = get_parent().get_parent().get_parent().get_node("Deck")

var area_input

var button_input

var dir
var norm_dir= Vector2(0,0)
var length

var dragging = false

var max_len = 200

var marker
var player

var range = 0


var card



func _process(delta):
	if dragging:
		card_sel["process_mode"] = Node.PROCESS_MODE_DISABLED
	else:
		card_sel["process_mode"] = Node.PROCESS_MODE_INHERIT

func _physics_process(delta):
	if norm_dir:
		marker.velocity = norm_dir * length
	else:
		marker.velocity =Vector2(0,0)
		
	#keeping in range
	if marker.global_position.distance_to(player.global_position) > range:
		var angle = marker.global_position - player.global_position
		angle = angle.normalized()
		marker.global_position = player.global_position + angle * range

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
				activate()
	
	area_input = false
	button_input = false



func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true


func _on_button_area_input_event(viewport, event, shape_idx):
	button_input = true
	
	
	
func activate():
	get_parent().hide_joys()
	card.deck = deck
	card.move_card(player, comb_world, marker)
	
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	
