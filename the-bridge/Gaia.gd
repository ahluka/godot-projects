# Gaia
#
# Manages scene switching and persistent game state.
# A hallmark of poor design!
#

extends Node

# Members
var current_scene = null

var player_persist = {
	health = 100,
}


func _ready():
#	var root = get_tree().get_root()
#	current_scene = root.get_child(root.get_child_count() - 1)
	randomize()
	load_test_level()


func load_test_level():
	var tlvl = load("res://TestLevel.tscn")
	get_parent().get_node("Universe").add_child(tlvl.instance())


# switch_scene
#	Unload the current_scene and load the specified one. Unloading is
#	deferred so we don't crash trying to free() an in-use scene.
func __switch_scene(path):
	current_scene.free()
	current_scene = ResourceLoader.load(path).instance()

	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func switch_scene(path):
	call_deferred("__switch_scene", path)

