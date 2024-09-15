extends Node


func _ready() -> void:
	pass # Replace with function body.



func later_ready():
	for sprite in get_tree().get_nodes_in_group("Sprite"):
		pass
		#change their colors with match statement
	for asprite in get_tree().get_nodes_in_group("AnimatedSprite"):
		pass
		#change their colors with match statement
