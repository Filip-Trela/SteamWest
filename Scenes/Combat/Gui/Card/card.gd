extends Node2D


var text_set

var player

var combat_world

var deck


var title
var description
var type
var player_toss
var skill
var skill_speed
var amount
var spread
var group
var enemy_toss
var damage



#for director
var activated = false


func _ready():
	title = text_set[0]
	description = text_set[1]
	type = text_set[2] 
	player_toss = int(text_set[3])
	skill = text_set[4]
	skill_speed = int(text_set[5])
	amount = int(text_set[6])
	spread = deg_to_rad(int(text_set[7]))
	enemy_toss = int(text_set[8])
	damage = int(text_set[9])
	
	
	
	$Title.text = title
	$Description.text = description
	




func rotate_card(player, combat_world, direction, len_strength):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	player.mov_vec += direction * len_strength * player_toss
	
	if skill != "null":
		var effect = load(skill)
		
		for single in range(amount):
			var effect_instance = effect.instantiate()
			effect_instance.global_position = player.global_position
			if single%2:
				effect_instance.mov_vec = direction.rotated(-spread * (single%2 + single)/2)
			else:
				effect_instance.mov_vec = direction.rotated(spread *(single%2 + single)/2)
			
			effect_instance.speed = skill_speed
			effect_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
			effect_instance.toss = enemy_toss
			effect_instance.damage = damage
			
			combat_world.add_child(effect_instance)
			
		#director next state
	get_tree().get_nodes_in_group("Director")[0].during_action = true

func move_card(player, combat_world, marker):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	var effect = load(skill)
	var effect_instance = effect.instantiate()
	effect_instance.global_position = marker.global_position
	effect_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
	combat_world.add_child(effect_instance)
	
	
	get_tree().get_nodes_in_group("Director")[0].during_action = true

func null_card(player, combat_world):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	var effect = load(skill)
	var effect_instance = effect.instantiate()
	effect_instance.global_position = player.global_position
	effect_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
	combat_world.add_child(effect_instance)
	
	
	get_tree().get_nodes_in_group("Director")[0].during_action = true



