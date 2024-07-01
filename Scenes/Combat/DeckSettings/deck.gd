extends Node

#for all cards

var draw_skills = []
var draw_move = []

var on_hand_skill = []
var on_hand_move = []

var discard_skill = []
var discard_move = []


var start_in_inv = 16
var max_on_hand = 4




func _process(delta):
	print("on hand: " + str(len(on_hand_move)) )
	print("draw smove: " + str(len(draw_move)) )





func start():
	var cards = FileAccess.get_file_as_string("res://Cards/cards_movement.txt")
	var cards_set = JSON.parse_string(cards)
	
	for skill in range(start_in_inv/ max_on_hand): 
		var r_card = cards_set.keys().pick_random()
		draw_move.append(cards_set[r_card].values())
		
	
	
	
	cards = FileAccess.get_file_as_string("res://Cards/card.txt")
	cards_set = JSON.parse_string(cards)
	
	for skill in range(start_in_inv - start_in_inv/ max_on_hand):
		var r_card = cards_set.keys().pick_random()
		draw_skills.append(cards_set[r_card].values())
		
	for place in range(max_on_hand):
		if place == 0:
			on_hand_move.append(draw_move[0])
			draw_move.pop_front()
			
		else:
			on_hand_skill.append(draw_skills[0])
			draw_skills.pop_front()
#Reset var function




func next_turn():
	#removes skill from hand, adds to discard
	for nr in range(len(on_hand_skill)):
		discard_skill.append(on_hand_skill[0])
		on_hand_skill.remove_at(0)
		
		
		
	#adds skills to hand from draw if is, if not then draw skill is discard and discard null

	if len(draw_skills) >= max_on_hand-1:
		for nr in range(max_on_hand-1):
			on_hand_skill.append(draw_skills[0])
			draw_skills.pop_front()
			
	else:
		draw_skills = discard_skill
		discard_skill = []
		for nr in range(max_on_hand-1):
			on_hand_skill.append(draw_skills[0])
			draw_skills.pop_front()
			
			
			
			
	
	
	#checks if move on hand, if true then nothing
	if on_hand_move:
		pass
	else:
		if len(draw_move) != 0:
			on_hand_move.append(draw_move[0])
			draw_move.pop_front()
		else:
			draw_move = discard_move
			discard_move = []
			on_hand_move.append(draw_move[0])
			draw_move.pop_front()
			
		
	#if isnt, if is draw move get, if not discard into draw and discard reset

func card_used(text_set):
	#for skills
	if text_set in on_hand_skill:
		discard_skill.append(text_set)
		on_hand_skill.remove_at(on_hand_skill.find(text_set))
		
		
	#for moves
	elif text_set in on_hand_move:
		discard_move.append(text_set)
		on_hand_move.remove_at(on_hand_move.find(text_set))
	
