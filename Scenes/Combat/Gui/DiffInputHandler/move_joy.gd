extends Node2D

var card_sel
var card_handler
var comb_world
var deck

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

var input_size

var text_set

func _ready() -> void:
	custom_ready()

func custom_ready():
	card_sel = get_parent().get_parent().get_node("CardSelected")
	card_handler = get_parent().get_parent().get_node("CardHandler")
	comb_world = get_parent().get_parent().get_parent().get_node("CombatWorld/NavigationRegion2D/Y_sort")
	deck = get_parent().get_parent().get_parent().get_node("Deck")
	input_size = Vector2($TouchArea.size.x/2, $TouchArea.size.y/2)

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
			$Joy.global_position = event.position - input_size
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
	
	
	
func activate():
	get_parent().hide_joys()
	card.deck = deck
	deck.card_used(text_set)
	card.move_card(player, marker)
	
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	


func _on_button_area_gui_input(event: InputEvent) -> void:
	button_input = true


func _on_touch_area_gui_input(event: InputEvent) -> void:
	area_input = true
