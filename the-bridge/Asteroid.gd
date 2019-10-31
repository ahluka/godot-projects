extends KinematicBody2D



func _ready():
	$ExplosionSprite.connect("animation_finished", self, "_on_anim_finished")
	$SFX.connect("finished", self, "_on_sfx_finished")


func _on_hit():
	$CollisionShape2D.disabled = true
	$Sprite.visible = false
	$ExplosionSprite.visible = true
	$ExplosionSprite.play()
	$SFX.play()


func _on_anim_finished():
	$ExplosionSprite.stop()
	$ExplosionSprite.visible = false


func _on_sfx_finished():
	self.queue_free()
