extends CPUParticles2D

func _process(dT):
	if not emitting:
		queue_free()

func _init():
	pass
