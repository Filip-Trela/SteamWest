extends Node2D


var text_set

var player


var title:String
var description:String
var amount:String
var type:String
var player_toss
var effect



func _ready():
	title = text_set[0]
	description = text_set[1]
	amount = text_set[2]
	type = text_set[3] 
	player_toss = text_set[4]
	effect = text_set[5]
	
	
	
	
	$Title.text = title
	$Description.text = description
	$Amount.text = amount
	





func rotate_card(player, direction, len_strength):
	player = player
	
	player.mov_vec += direction * len_strength * int(player_toss)
	
	if type != "null":
		pass
	

func move_card(player):
	player = player


func null_card(player):
	player = player
