extends Node

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	# The $ is syntactic sugar for get_node()
	$Sprite.visible = !$Sprite.visible
