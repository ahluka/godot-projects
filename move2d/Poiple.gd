extends KinematicBody2D

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.stop()
