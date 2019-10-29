extends Node2D

func display_frame_info(label: Label, delta):
	var fps = Engine.get_frames_per_second()
	var frame = Engine.get_frames_drawn()
	label.text = "frame: " + str(frame) + " FPS: " + str(fps) + \
		" dT: " + str(delta)


func _process(delta):
	display_frame_info($FPSLabel, delta)
