extends Node


func _process(delta):
	update_debug_overlay()
	update_hud()


func update_debug_overlay():
	var fps = Engine.get_frames_per_second()
	$DebugOverlay/FPSLabel.text = "FPS: " + str(fps)


func update_hud():
	$HUD/HP.text = "Health: " + str(Gaia.player_persist["health"])
