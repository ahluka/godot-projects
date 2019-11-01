extends KinematicBody2D

var velocity: Vector2
var move_speed := 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	process_input()
	velocity = move_and_slide(velocity)


func process_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
	if Input.is_action_pressed("right"):
		velocity.x += move_speed

