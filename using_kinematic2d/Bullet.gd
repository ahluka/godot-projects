extends KinematicBody2D

var speed = 750
var velocity = Vector2()
var sparks = preload("res://Sparks.tscn")


func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		collision_fx(collision)
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func collision_fx(collision):
	var s = sparks.instance()
	s.emitting = true
	s.position = collision.position
	get_parent().add_child(s)
	pass
