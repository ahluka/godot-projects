extends KinematicBody2D

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()

