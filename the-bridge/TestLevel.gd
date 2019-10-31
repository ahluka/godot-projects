extends Node2D

var Asteroid = preload("res://Asteroid.tscn")


func _ready():
	spawn_asteroids(10)


func spawn_asteroids(num: int) -> void:
	print_debug("Spawning %s Asteroids" % num)
	for i in range(0, num):
		var a = Asteroid.instance()
		a.position = $Player.position + Vector2(rand_range(-900.0, 900.0), \
												rand_range(-900.0, 900.0))
		add_child(a)
