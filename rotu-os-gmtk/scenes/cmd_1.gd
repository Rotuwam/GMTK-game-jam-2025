extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal closed # emits a "closed" signal

func _on_button_pressed() -> void:
	emit_signal("closed")
	animation_player.play("pop_out")
	var timer = Timer.new()
	timer.wait_time = 0.5  # 0.5seconds the duration of the animation 
	timer.one_shot = true
	timer.timeout.connect(delete) # when timer runds out delete from the scene
	add_child(timer)
	timer.start()

func delete():
	queue_free()
