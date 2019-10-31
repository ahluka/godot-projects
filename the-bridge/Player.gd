# Player
#
# Player controller.
# Things that need changing / fixing:
#	* Sfx code is mixed into input handling and other places. Could be moved
#	  into its own node (i.e. class) to spin up individual AudioStreamPlayers
#	  as necessary to mix multiple sfx. For now, the Player just needs to play
#	  movement sfx. Gunshots etc. are handled by separate scenes.
#
#	

extends KinematicBody2D

# Preloads
var LaserBolt = preload("res://LaserBolt.tscn")


# Exports
export (float) var boost_scale = 2.25
export (float) var current_speed = 0
export (float) var max_speed = 300
export (float) var accel = 10
export (float) var decay = 8


# Member vars
var velocity: Vector2
var boosting = false
var thrusting = false


func prepare_starfield_tex():
	var tex = $StarfieldLayer/Starfield.texture
	var res = Vector2(tex.get_width(), tex.get_height())
	$StarfieldLayer/Starfield.material.set_shader_param("screen_res", res)


func _ready():
#	prepare_starfield_tex()
	$ThrustStream.volume_db = -10
	$BoostStream.volume_db = -10


func _physics_process(delta):
	get_input()
	var coll = move_and_collide(velocity * delta)
	if coll:
		if coll.collider.has_method("_on_hit"):
			coll.collider._on_hit()
		Gaia.player_persist["health"] -= 25

	play_sfx()
	play_vfx()


func get_input():
	velocity = Vector2.ZERO
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("thrust"):
		current_speed += accel
		thrusting = true
	elif not Input.is_action_pressed("thrust") and current_speed > 0:
		current_speed -= decay
		thrusting = false

	current_speed = clamp(current_speed, 0, max_speed)
	velocity = Vector2(current_speed, 0).rotated(self.rotation)

	if Input.is_action_pressed("boost") and thrusting:
		velocity *= boost_scale
		boosting = true
	else:
		boosting = false

	if Input.is_action_just_pressed("boost") and thrusting:
		$BoostStream.play()

	if Input.is_action_just_pressed("std_attack"):
		fire_std_attack()


func fire_std_attack():
	var lb = LaserBolt.instance()
	lb.fire(self.position, self.rotation)
	get_parent().add_child(lb)


func take_damage(amount: int) -> void:
	Gaia.player_persist["health"] -= amount
	if Gaia.player_persist["health"] <= 0:
		die()


func die() -> void:
	pass


func play_sfx():
	if thrusting:
		if not $ThrustStream.playing:
			$ThrustStream.play()
	else:
		$ThrustStream.stop()


func play_vfx():
	if thrusting:
		$AnimatedSprite/Exhaust.emitting = true
	else:
		$AnimatedSprite/Exhaust.emitting = false

	if boosting:
		$AnimatedSprite/ExhaustBoost.emitting = true
	else:
		$AnimatedSprite/ExhaustBoost.emitting = false
