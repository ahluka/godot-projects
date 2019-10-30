extends Node


func _process(delta):
	update_debug_overlay()


func update_debug_overlay():
	var fps = Engine.get_frames_per_second()
	$DebugOverlay/FPSLabel.text = "FPS: " + str(fps)
