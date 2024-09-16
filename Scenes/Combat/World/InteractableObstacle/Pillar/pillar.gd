extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().env_destroy:
		$Area2D.queue_free()
		$Sprite2D2.visible = false #change later
		collision_layer = 16
		
	area.get_parent().destroy()
	
