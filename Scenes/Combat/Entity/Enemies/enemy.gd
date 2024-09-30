extends Entity

class_name Enemy

@onready var entity_label_pl = preload("res://Scenes/Combat/Gui/EntityLabel/entity_label.tscn")

@onready var combat_gui = get_parent().get_parent().get_parent().get_node("CombatGui")

var timer_label = 0.8
var label_name = "Enemy numbero uno forevero"

var player:CharacterBody2D

@onready var navi_ag:NavigationAgent2D = $NavigationAgent2D


#for behaviour
var range_to_p = "far" #close, mid, far

var danger_arr = []

@onready var timer_b = $TimerActions
var state_beh = "waiting" #behaviour state
#waiting, in danger, following player, running away from player
#going sideways, dead, shooting, attacking melee, between, during action
var can_behave = false

var last_acts = ["none","waiting"]
#waiting, none, in danger, following player, running away from player
#going sideways, dead, shooting, attacking melee



var can_act = false

var path
var path1
var path2

var angle_tolerance = 10
var curve = 40
var curve_addition = 10



@onready var card_pl = preload("res://Scenes/Combat/Gui/Card/card.tscn")
var card


var cards_mov = []
var cards_skill = []

var card_dir = Vector2(0,0)
var length = 0.0 #0.0-1.0


var lower_for_calc = 55.55556


var ray_col = false


func custom_ready():
	card = card_pl.instantiate()
	$Invisible.add_child(card)
	$HurtBox["collision_layer"] = 8
	player = get_tree().get_first_node_in_group("Player")
	navi_ag.target_position = player.global_position
	
	timer_b.start(randf_range(0.2, 0.4))
	set_cards()
	
	navi_ag.path_desired_distance = 4.0
	navi_ag.target_desired_distance = 4.0
	

func set_cards():
	var cards = FileAccess.get_file_as_string("res://Settings/cards_movement.txt")
	var cards_set = JSON.parse_string(cards)
	
	#cards_mov.append(cards_set[cards_set].values())
	var r_card = cards_set.keys().pick_random()
	cards_mov = cards_set[r_card].values()
	
	#SKILLS
	cards = FileAccess.get_file_as_string("res://Settings/card.txt")
	cards_set = JSON.parse_string(cards)
	r_card = cards_set.keys()
	cards_skill = cards_set[r_card[0]].values()

	navi_ag.target_position = player.global_position
	navi_ag.get_next_path_position()




#BEHAVIOUR AND NAVIGATING
func custom_process():

	if timer.paused:
		timer_b.paused = true
	else:
		timer_b.paused = false
	
	ray_col = $RayCast2D.is_colliding()
	
	path = navi_ag.get_current_navigation_path()
	navi_ag.target_position = player.global_position
	navi_ag.get_next_path_position()
	
	#navi_ag.target_position = player.global_position
	
	$RayCast2D.target_position = player.global_position - self.global_position
	
	var distance_to_player = self.global_position.distance_to(player.global_position)
	if distance_to_player < 180:
		range_to_p = "close"
	elif distance_to_player < 600:
		range_to_p = "mid"
	else:
		range_to_p = "far"
	
	if state_beh == "between":
		behaviour()
	behaviour_actions()

	


func behaviour():
	pass


func behaviour_actions():
	match state_beh:
		"waiting":
			dir = Vector2(0,0)
			speed = move_toward(speed,0, deceleration)
				
		"following player":
			following_player()
			
		"in danger":
			danger()
		
		"running away from player": pass
		"going sideways": pass
		"dead": pass
		"shooting": 
			shooting()
		"attacking melee": pass
		"between": pass
		"during action": pass
			
			 #running away from player
#going sideways, dead, shooting, attacking melee
			



func following_player():
	if can_act:
		navi_ag.target_position = player.global_position
		navi_ag.get_next_path_position()
		
		#Setting path angle
		if len(path) == 2:
			path1 = rad_to_deg(Vector2(path[1] - path[0]).normalized().angle())
			if path1 < 0:
				path1 = path1 * -1
			else:
				path1 = 180 + (180- path1)
			move_straight(0)
		
		elif len(path) >2:
			#settings second path angle
			path1 = rad_to_deg(Vector2(path[1] - path[0]).normalized().angle())
			path2 = rad_to_deg(Vector2(path[2] - path[1]).normalized().angle())
			if path1 < 0:
				path1 = path1 * -1
			else:
				path1 = 180 + (180- path1)
			if path2 < 0:
				path2 = path2 * -1
			else:
				path2 = 180 + (180- path2)
			
			
			#moving
			#straight
			if abs(path2 - path1) < angle_tolerance:
				move_straight(0)
			
			#on curves
			elif abs(path2 - path1) > angle_tolerance:
				if path2 - path1 > curve:
					move_straight(curve_addition)
				elif path2 - path1 < -curve:
					move_straight(-curve_addition)
				#rest
				elif path2 - path1 > 0:
					move_straight(curve_addition / 2)
				elif path2 - path1 < 0:
					move_straight(-curve_addition / 2)
					
					

			
func move_straight(add_rotation):
	var current_strength = speed
	var strength = int(cards_mov[3]) / lower_for_calc
	var fps = int(60 * float(cards_mov[10])) #not fps but frames allowed to move
	var low_dec = deceleration_normal / lower_for_calc
			
	#calka oznaczona, w notatkach fizycznych
	var max_move = ((current_strength + strength) * fps) - (low_dec * fps * fps * 0.5)
	var distance = global_position.distance_to(player.global_position)
	
	last_act_set("following player")
		
	if max_move < distance:
		length = 1.0
		card_dir = Vector2(1,0).rotated(deg_to_rad(-path1))
		
		#additional plus rotationg if curve
		card_dir = card_dir.rotated(deg_to_rad(add_rotation))
			
	if length > 0.2:
		card.text_set = cards_mov
		card.rotate_card(self, card_dir, length)
		length = 0.0
		card_dir = Vector2(1,0)
			

func danger():
	if can_act:
		if danger_arr.back().get_parent().get_parent().danger_type == "moving":
			length = 1.0
			card_dir = danger_arr.back().get_parent().get_parent().mov_vec.normalized()
			card_dir = card_dir.rotated(PI/2 * [-1,1].pick_random())
			
			
			last_act_set("in danger")
			
			card.text_set = cards_mov
			card.rotate_card(self, card_dir, length)
			length = 0.0
			card_dir = Vector2(1,0)


func shooting():

	if can_act:
		last_act_set("shooting")
		var shot_dir = player.global_position - self.global_position
		shot_dir = shot_dir.normalized()
		
		card.text_set = cards_skill
		card.rotate_card(self, shot_dir, 1)









func last_act_set(action_name):
	last_acts.pop_front()
	last_acts.append(action_name)
	

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			$TimerLabel.start(timer_label)
		else:
			$TimerLabel.stop()


func _on_timer_label_timeout() -> void:
	var entity_label = entity_label_pl.instantiate()
	entity_label.entity_name = label_name
	
	combat_gui.add_child(entity_label)



func _on_timer_actions_timeout() -> void:
	can_act = true
	state_beh = "between"


func action_timer_start(recovery_time):
	can_act = false
	state_beh = "during action"
	$TimerActions.start(recovery_time)


func _on_danger_zone_area_entered(area: Area2D) -> void:
	if area not in danger_arr:
		danger_arr.append(area)


func _on_danger_zone_area_exited(area: Area2D) -> void:
	if area in danger_arr:
		danger_arr.remove_at(danger_arr.find(area))
