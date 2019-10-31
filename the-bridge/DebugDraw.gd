extends Node2D

var debug_font = preload("res://assets/terminus.fnt")
var Asteroid = preload("res://Asteroid.gd")

func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	self.global_rotation = 0
	self.update()


func _draw():
	draw_loc_rot()
	draw_target_vec()
	draw_nearby_vecs()


func draw_nearby_vecs():
	var p = get_parent()
	var area = p.get_node("DetectionArea")
	var nearby = area.get_overlapping_bodies()
	for body in nearby:
		if body is Asteroid:
			draw_line(Vector2(0,0), to_local(body.position), Color(0, 1, 1, 0.5), 1)


func draw_loc_rot():
	var p = get_parent()
	var strpos = Vector2(0, -50)
	var strx = str(p.position.x)
	var stry = str(p.position.y)
	var strrot = str(p.rotation_degrees)

	draw_string(debug_font, strpos, strx + "," + stry)
	draw_string(debug_font, strpos + Vector2(0, -20), strrot)
	var vn = p.velocity
	var strvel = "v: " + str(vn.x) + ", " + str(vn.y)
	draw_string(debug_font, strpos + Vector2(0, -40), strvel)


func draw_target_vec():
	draw_line(Vector2(0,0), get_local_mouse_position(), Color(1,0,0, 0.5), 1)
