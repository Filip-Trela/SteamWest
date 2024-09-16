extends Node2D

var card_sel
var card_handler
var comb_world
var deck


@onready var shadow_pl = preload("res://Scenes/Combat/Markers/Shadow/shadow.tscn")

var dir
var norm_dir = Vector2(0,0)
var length = 0

var dragging = false

var max_len = 200

var marker
var player


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
	input_size = Vector2($ColorRect.size.x/2, $ColorRect.size.y/2)
	

func _process(delta):
	if dragging:
		card_sel["process_mode"] = Node.PROCESS_MODE_DISABLED
	else:
		card_sel["process_mode"] = Node.PROCESS_MODE_INHERIT
		
	marker.rotation = -norm_dir.angle_to(Vector2(0, -1))
	marker.scale = Vector2(1, length / max_len)
	
	
	
	if not len(get_tree().get_nodes_in_group("Shadow")) and length > 50:
		var shadow = shadow_pl.instantiate()
		shadow.global_position = player.global_position
		
		#getting speed from player
		shadow.speed = player.speed
		shadow.dir_current = player.dir_current
		shadow.dir = player.dir
		
		var player_toss = int(text_set[3])
		if player_toss > 0:
			shadow.dir = norm_dir
			shadow.speed += length/200 * player_toss
		elif player_toss < 0:
			shadow.dir = Vector2(-norm_dir.x, -norm_dir.y)
			shadow.speed += length/200 * abs(player_toss)
		

			
		
		comb_world.add_child(shadow)




func activate():
	get_parent().hide_joys()
	card.deck = deck
	deck.card_used(text_set)
	card.rotate_card(player, norm_dir, length/max_len)
	length = 0
	
	
	card_sel.activate()
	card_handler.remove_high_card()
	
	
	
	
	


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		if dragging:
			$Joy.position = event.position - input_size
			dir = $Joy.position - self.position
			norm_dir = dir.normalized()
			length = ($Joy.position - self.position).length()
			
			if length >= max_len:
				$Joy.position = self.position + norm_dir * max_len
				length = max_len
				
			dragging = true
			
		else:
			$Joy.position = event.position - input_size
			dir = $Joy.position - self.position
			norm_dir = dir.normalized()
			length = ($Joy.position - self.position).length()
			
			if length >= max_len:
				$Joy.position = self.position + norm_dir *max_len
				length = max_len
				
			dragging = true
			
			
	elif event is InputEventScreenTouch:
		if dragging and not event.pressed:
			dragging = false
			if length <50:
				$Joy.position = self.position
				length = 0
			else:
				$Joy.position = self.position
				activate()
