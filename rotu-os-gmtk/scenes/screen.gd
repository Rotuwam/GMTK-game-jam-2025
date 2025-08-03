extends Node2D


var CMD1 = load("res://scenes/cmd_1.tscn")
@onready var button: Button = $Button

@onready var game_timer: Timer = $Control/GameTimer
@onready var label: Label = $Control/Label




var time_left = 30 #30 seconds


func _ready() -> void:
	label.text = str(time_left) # show the timer text on screen
	var cmd1_timer = Timer.new()
	cmd1_timer.wait_time = 1.0 # 1 second
	cmd1_timer.one_shot = true
	cmd1_timer.timeout.connect(instructions)
	add_child(cmd1_timer)
	cmd1_timer.start()

func _on_button_pressed() -> void:
	instructions()

func _on_cmd_closed():
	button.disabled = false


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")



func _on_game_timer_timeout() -> void:
	time_left -= 1 # remove one value from the timer value each second
	label.text  = str(time_left)
	if time_left <= 0:
		game_timer.stop()
		get_tree().change_scene_to_file("res://scenes/blue_screen.tscn") # when the timer stops go to the bluescreen

func quit_game():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit() #quit game with alt f4

func instructions():  #pop up CMD1 
	var instance = CMD1.instantiate() #instatiate the CMD1 scene 
	instance.position = Vector2(0, 0)
	instance.visible = true
	add_child(instance)
	#play pop_in animation when instantiated
	var anim_player = instance.get_node("AnimationPlayer")
	if anim_player:
		anim_player.play("pop_in")

		button.disabled = true # doesn't allow player to open more than one CMD1 window
		instance.closed.connect(_on_cmd_closed) # makes sure you can open the window again once they close it
