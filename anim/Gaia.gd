extends Node

var current_scene = null

func _ready():
	# Fetch the current scene. Autoloaded nodes are always loaded first,
	# so the last child of root is always the loaded scene.
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print("[GAIA] currentScene: " + current_scene.name)

func goto_scene(path):
	# Can't delete the current scene now since it's running.
	# Instead, we defer the call until later, when no code is running.
	call_deferred("__goto_scene", path)

func __goto_scene(path):
	# Safe to free it now
	current_scene.free()

	var scn = ResourceLoader.load(path)
	current_scene = scn.instance()

	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
