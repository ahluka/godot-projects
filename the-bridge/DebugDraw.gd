extends Node2D

var debug_font = preload("res://assets/terminus.fnt")

func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	self.global_rotation = 0
	self.update()


func _draw():
	draw_line(Vector2(0,0), get_local_mouse_position(), Color(1,0,0), 1)
