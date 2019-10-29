extends Area2D

signal hit

export var speed = 400	# movement speed in pixels/sec
var screen_size
var target = Vector2()
var vel = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton and event.pressed:
		target = event.position

func _process(delta):
	# Move towards target and stop when close
	if position.distance_to(target) > 10:
		vel = (target - position).normalized() * speed
	else:
		vel = Vector2()

	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += vel * delta

	# select animation
	if vel.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = vel.x < 0
	elif vel.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = vel.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
