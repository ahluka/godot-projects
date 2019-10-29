extends Node2D

var dbgfn = preload("res://terminus.fnt") as Font

func _ready():
	pass

func _physics_process(delta):
	global_rotation = 0
	update()

func _draw():
	var strpos = Vector2(0, -50)

	draw_line(Vector2(0,0), get_local_mouse_position(), Color(1,0,0))
	draw_circle(Vector2(0,0), 10, Color(1,0,0))
	draw_string(dbgfn, strpos, str(position))
