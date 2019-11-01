extends KinematicBody

var gravity = -12
var speed = 4
var jump_speed = 6
var spin = 0.1

var velocity: Vector3
var jump = false


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, spin, event.relative.x / 10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, spin, event.relative.x / 10))


func get_input():
	var vy = velocity.y
	velocity = Vector3()

	if Input.is_action_pressed("move_forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("move_back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("strafe_left"):
		velocity += -transform.basis.x * speed
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * speed
	velocity.y = vy

	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true


func _physics_process(delta):
	var grav = Vector3(0, gravity, 0)
	velocity += grav * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
