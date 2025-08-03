extends Node2D


var timer = Timer.new()


func _ready() -> void:
	timer.wait_time = 5.0 # 5 seconds
	timer.one_shot
	timer.timeout.connect(restart)
	add_child(timer)
	timer.start()

func restart():
	get_tree().change_scene_to_file("res://scenes/screen.tscn") 

#after 3 e5conds the bluescreen will revert back to the game scene


func quit_game():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit() #quit game with alt f4
