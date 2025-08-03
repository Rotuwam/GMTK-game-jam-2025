extends Node2D


var hand_point = preload("res://Assets/hand_thin_point.png")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen.tscn")


func quit_game():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit() #quit game with alt f4



func _on_quit_pressed() -> void:
	get_tree().quit() #quit game button
