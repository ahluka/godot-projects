extends KinematicBody2D

export (int) var move_speed = 200

var velocity: Vector2


func _ready():
	# Forward velocity is actually down the X axis ("right") so we need to
	# rotate the sprite (which is facing "up" the Y axis)
	$AnimatedSprite.rotate(PI / 2)


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func get_input():
	velocity = Vector2.ZERO
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("thrust"):
		velocity = Vector2(move_speed, 0).rotated(self.rotation)
