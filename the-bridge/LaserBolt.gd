extends KinematicBody2D

var velocity: Vector2
export (int) var speed = 1200


func _ready():
	$SFX.volume_db = -10
	$LifetimeTimer.connect("timeout", self, "_on_LifetimeTimer_timeout")


func fire(start_pos, dir):
	self.position = start_pos
	self.rotation = dir
	velocity = Vector2(speed, 0).rotated(self.rotation)
	$SFX.play()


func _physics_process(delta):
	var coll = move_and_collide(velocity * delta)
	if coll:
		if coll.collider.has_method("_on_hit"):
			coll.collider._on_hit()
		self.queue_free()


func _on_LifetimeTimer_timeout():
	self.queue_free()
