extends Node2D

@onready var card_sel = get_parent().get_parent().get_node("CardSelected")
@onready var card_handler = get_parent().get_parent().get_node("CardHandler")
@onready var comb_world = get_parent().get_parent().get_parent().get_node("CombatWorld")
@onready var deck = get_parent().get_parent().get_parent().get_node("Deck")

var area_input

var dir
var norm_dir = Vector2(0,0)
var length = 0

var dragging = false

var max_len = 200

var marker
var player


var card



func _process(delta):
	if dragging:
		card_sel["process_mode"] = Node.PROCESS_MODE_DISABLED
	else:
		card_sel["process_mode"] = Node.PROCESS_MODE_INHERIT
		
	marker.rotation = -norm_dir.angle_to(Vector2(0, -1))
	marker.scale = Vector2(1, length / max_len)


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
			
			
	elif event is InputEventScreenTouch:
		if dragging and not event.pressed:
			dragging = false
			if length <50:
				$Joy.global_position = self.global_position
			else:
				$Joy.global_position = self.global_position
				activate()
	
	area_input = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true


func activate():
	get_parent().hide_joys()
	card.deck = deck
	card.rotate_card(player, comb_world, norm_dir, length/200)
	
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	
	
	
