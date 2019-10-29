extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get ready!")
	$Music.play()

func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func _on_MobTimer_timeout():
	# Choose a random location on Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	# Create mob and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	
	# Set the mob's direction perpendicular to the path direction
	# and add some randomness
	var dir = $MobPath/MobSpawnLocation.rotation + PI / 2
	dir += rand_range(-PI / 4, PI / 4)

	mob.position = $MobPath/MobSpawnLocation.position
	mob.rotation = dir

	# Set velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(dir)

	$HUD.connect("start_game", mob, "_on_start_game")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
