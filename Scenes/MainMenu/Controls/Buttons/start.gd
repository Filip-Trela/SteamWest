extends CustomButton

@onready var main_menu = get_parent().get_parent()
@onready var game = get_parent().get_parent().get_parent()
@onready var combat_pl = preload("res://Scenes/Combat/combat.tscn")
var combat

func activate():
	combat = combat_pl.instantiate()
	game.add_child(combat)
	main_menu.queue_free()
