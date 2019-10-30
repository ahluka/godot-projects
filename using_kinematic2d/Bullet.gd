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
		if collision.collider.get_class() == "KinematicBody2D":
			self.queue_free()

		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# FIXME: This should really be taken care of by each collider's hit() method
# as per _physics_process() above. Adding it here was quicker for testing.
func collision_fx(collision: KinematicCollision2D):
	var s = sparks.instance()
	s.emitting = true
	s.position = collision.position
	if collision.collider.get_class() == "KinematicBody2D":
		s.color = Color(1,0,0)
		s.scale_amount = 5
		s.color_ramp = null

	get_parent().add_child(s)
	pass
