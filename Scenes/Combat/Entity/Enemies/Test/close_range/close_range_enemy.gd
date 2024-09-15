extends Enemy





func  behaviour():
	match state_beh:
		"waiting":
			dir = Vector2(0,0)
			speed = move_toward(speed,0, deceleration)
		"following":
			pass
			#dir = Vector2(navi_ag.get_next_path_position() - self.global_position).normalized()
			#speed = 200
		"in danger":
			pass
