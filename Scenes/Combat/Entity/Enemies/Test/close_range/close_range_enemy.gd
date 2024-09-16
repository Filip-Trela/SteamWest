extends Enemy



var cards_mov = []

var card_dir = Vector2(0,0)
var length = 0.0 #0.0-1.0

func set_cards():
	var cards = FileAccess.get_file_as_string("res://Cards/cards_movement.txt")
	var cards_set = JSON.parse_string(cards)
	
	#cards_mov.append(cards_set[cards_set].values())
	var r_card = cards_set.keys().pick_random()
	cards_mov = cards_set[r_card].values()

func  behaviour():
	match state_beh:
		"waiting":
			dir = Vector2(0,0)
			speed = move_toward(speed,0, deceleration)
			if can_act:
				state_beh = "following"
		"following":
			navi_ag.get_next_path_position()
			moving()
			#dir = Vector2(navi_ag.get_next_path_position() - self.global_position).normalized()
			#speed = 200
		"in danger":
			pass


func moving():
	if len(path) >2:
		print("calculating")
		var path1 = rad_to_deg(Vector2(path[1] - path[0]).normalized().angle())
		var path2 = rad_to_deg(Vector2(path[2] - path[1]).normalized().angle())
		
		#ogarniecie katow aby bylo mi latwiej, git jest
		if path1 < 0:
			path1 = path1 * -1
		else:
			path1 = 180 + (180- path1)
		if path2 < 0:
			path2 = path2 * -1
		else:
			path2 = 180 + (180- path2)
			
		
			#PIERWSZE ZACHOWANIE RUCHOWE, CZYLI IDZ PROSTO
		if abs(path2 - path1) < angle_tolerance:
			#max distance of movement
			var current_strength = speed
			var strength = int(cards_mov[3]) / lower_for_calc
			var fps = int(60 * float(cards_mov[10])) #not fps but frames allowed to move
			var low_dec = deceleration_normal / lower_for_calc
			
			#calka oznaczona, w notatkach fizycznych
			var max_move = ((current_strength + strength) * fps) - (low_dec * fps * fps * 0.5)
			var distance = global_position.distance_to(player.global_position)
			print("calculated")
			
			if max_move < distance:
				length = 1.0
				card_dir = Vector2(1,0).rotated(deg_to_rad(-path1))
				
				
		
		
	#finish
	if can_act and length > 0.2:
		card.text_set = cards_mov
		card.rotate_card(self, card_dir, length)
		length = 0.0
		card_dir = Vector2(1,0)
