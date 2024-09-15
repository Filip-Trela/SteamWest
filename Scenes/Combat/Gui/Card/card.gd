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
var recovery_time



#for director
var activated = false

var timer


func _ready():
	timer = get_tree().get_nodes_in_group("Timer")[0]
	
	
	title = text_set[0]
	description = text_set[1]
	type = text_set[2] 
	player_toss = int(text_set[3])
	skill = text_set[4] #TODO prawdopodobnie zmienic na inna nazwe
	skill_speed = int(text_set[5])
	amount = int(text_set[6])
	spread = deg_to_rad(int(text_set[7]))
	enemy_toss = int(text_set[8])
	damage = int(text_set[9])
	recovery_time = float(text_set[10])
	
	
	
	$Title.text = title
	$Description.text = description
	




func rotate_card(player, combat_world, direction, len_strength):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	if text_set[11] != "None":
		var eff = load(text_set[11]).instantiate()
		eff.global_position = player.global_position
		var dir = Vector2(direction.x, direction.y)
		dir = dir.rotated(deg_to_rad(int(text_set[12])))
		eff.set_gravity(Vector2(dir.x, dir.y))
		
		if text_set[13] == "true":
			eff.keep_target = player
		combat_world.add_child(eff)
	
	
	if player_toss > 0:
		player.dir = direction
		player.speed += len_strength * player_toss
	elif player_toss < 0:
		player.dir = Vector2(-direction.x, -direction.y)
		player.speed += len_strength * abs(player_toss)
	
	if skill != "null":
		var skill = load(skill)
		
		for single in range(amount):
			var skill_instance = skill.instantiate()
			skill_instance.global_position = player.global_position
			if single%2:
				skill_instance.mov_vec = direction.rotated(-spread * (single%2 + single)/2)
			else:
				skill_instance.mov_vec = direction.rotated(spread *(single%2 + single)/2)
			
			skill_instance.speed = skill_speed
			skill_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
			skill_instance.toss = enemy_toss
			skill_instance.damage = damage
			if text_set[14] == "true":
				skill_instance.env_destroy = true
			
			combat_world.add_child(skill_instance)
			
	timer.start(recovery_time)


#TODO change after doing rotate
func move_card(player, combat_world, marker):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	var skill = load(skill)
	var skill_instance = skill.instantiate()
	skill_instance.global_position = marker.global_position
	skill_instance.damage = damage
	skill_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
	combat_world.add_child(skill_instance)
	
	
	timer.start(recovery_time)

#TODO change after doing rotate
func null_card(player, combat_world):
	deck.card_used(text_set)
	
	player = player
	combat_world = combat_world
	
	var skill = load(skill)
	var skill_instance = skill.instantiate()
	skill_instance.global_position = player.global_position
	skill_instance.damage = damage
	skill_instance.get_node("Area2D")["collision_mask"] = 10 #enemy and world
	combat_world.add_child(skill_instance)
	
	
	timer.start(recovery_time)
