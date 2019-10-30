extends KinematicBody2D

export (int) var move_speed = 250
export (int) var gravity = 1000
export (int) var jump_speed = -400

var vel = Vector2()
var jumping = false


func _ready():
	pass

func _physics_process(delta):
	get_input()

	vel.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false

	vel = self.move_and_slide(vel, Vector2(0, -1))

func get_input():
	vel.x = 0
	if Input.is_action_pressed("left"):
		vel.x -= move_speed
		$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		vel.x += move_speed
		$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
		vel.x = 0

	# Ugly hack to fix the sprite issue...
	if $AnimatedSprite.animation == "move":
		$AnimatedSprite.offset.y = 40
	else:
		$AnimatedSprite.offset.y = 0

	if Input.is_action_pressed("jump") and is_on_floor():
		jumping = true
		vel.y += jump_speed

	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite.play("attack")
		yield($AnimatedSprite, "animation_finished")
