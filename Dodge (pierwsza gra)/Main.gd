extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HJD.show_message("Get Ready")
	$HJD.update_score(score)

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HJD.game_over()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HJD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
