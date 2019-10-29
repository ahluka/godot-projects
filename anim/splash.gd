extends TextureRect

var nextScene = preload("Spinner.tscn")

func _on_start_pressed():
#	$AnimationPlayer.play("intro")
	Gaia.goto_scene("res://Spinner.tscn")
