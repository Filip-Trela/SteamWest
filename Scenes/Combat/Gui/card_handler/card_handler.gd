extends Node2D

@onready var card_pl = preload("res://Scenes/Combat/Gui/Card/card.tscn")

#difference of all card, 360 / nr of cards
var angle_diff

var card_pos = Vector2(1,0)
var card_xy = Vector2(220, 20) #for multiplying position
var high_y = 60 #for central card

var all_cards
var high_card

var drag_x = 0.0
var drag_sens = 0.007

var area_input = false


var pressed= false
var dragging = false

@onready var selector = get_parent().get_node("CardSelected")
@onready var diff_input = get_parent().get_node("DiffInputHandler")
@onready var deck = get_parent().get_parent().get_node("Deck")



#TESTS
var cards_file = "res://Cards/card.txt"
var cards
var cards_set:Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	cards = FileAccess.get_file_as_string(cards_file)
	cards_set = JSON.parse_string(cards)
	
	deck.start()
	card_set_start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	card_set_update()


func _input(event):
	if event is InputEventScreenTouch:
		if area_input:
			if event.pressed and not dragging and not pressed:
				$Timer.start(Settings.drag_timer)
				pressed = true
				
			elif not event.pressed:
				if dragging == false:
					activate()
				pressed = false
				dragging = false
				$Timer.stop()
		
	elif event is InputEventScreenDrag:
		if area_input:
			if dragging:
				drag_x += event.relative.x * drag_sens
			
	

			
	area_input = false



func card_set_start():
	for number in range(4):
		var choosen_card
		var card
		
		if number ==0:
			choosen_card = deck.on_hand_move[0]
		else:
			choosen_card = deck.on_hand_skill[number-1]
		
		card = card_pl.instantiate()
		
		
		#setting information about card
		card.text_set = choosen_card
		
		
		#setting position
		card.rotation = deg_to_rad(180)
		#card.position = card_pos.rotated(angle_diff * number)
		card.position.x = card.position.x * card_xy.x
		card.position.y = card.position.y * card_xy.y
		
		$Cards.add_child(card)
	
	
	
func card_set_update():
	angle_diff = deg_to_rad( 360/ $Cards.get_child_count())
	
	for nr in len($Cards.get_children()):
		var card = $Cards.get_child(nr)
		card.position = card_pos.rotated(angle_diff * nr + drag_x)
		card.position.x = card.position.x * card_xy.x
		card.position.y = card.position.y * card_xy.y
		
	for card in $Cards.get_children():
		card["modulate"] = (Color8(177,177,177,255))
		if high_card:
			if high_card.position.y < card.position.y:
				high_card = card
		else:
			high_card = card
			
	high_card["modulate"] = (Color8(255,255,255,255))

	high_card.position.y = high_y


func next_turn():
	for card in $Cards.get_children():
		card.queue_free()
		
	card_set_start()
	
	high_card = null
	
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	area_input = true

func _on_timer_timeout():
	dragging = true


func activate():
	selector.card_selected(high_card)
	diff_input.start(high_card.text_set)
	
	visible = false
	self["process_mode"] = Node.PROCESS_MODE_DISABLED


func remove_high_card():
	high_card.queue_free()
	high_card = null
