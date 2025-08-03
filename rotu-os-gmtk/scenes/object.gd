extends Node2D


@onready var object: Sprite2D = $Object
@onready var button: Button = $Button
@onready var area_2d: Area2D = $Area2D

@onready var trash_bin: Area2D = $"../../TrashBin"
@onready var game_timer: Timer = $"../../Control/GameTimer"


var dragging = false
var of = Vector2(0,0)
var is_overlapping : bool = false

var CMD2 = load("res://scenes/cmd_2.tscn")
var BlueScreen = load("res://scenes/blue_screen.tscn")

var hand_open = preload("res://Assets/hand_thin_open.png")
var hand_closed = preload("res://Assets/hand_thin_closed.png")
var normal_cursor = preload("res://Assets/cursor_none.png")

func _ready():
	if not button.button_down.is_connected(_on_button_button_down):
		button.button_down.connect(_on_button_button_down)
	if not button.button_up.is_connected(_on_button_button_up):
		button.button_up.connect(_on_button_button_up)
		#double ensuring signals are connected 

func _process(_delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position
	Input.set_custom_mouse_cursor(hand_closed, Input.CURSOR_ARROW, Vector2(16,16))


func _on_button_button_up() -> void:
	dragging = false
	if is_overlapping == true:
		in_trash()
	else:
		Input.set_custom_mouse_cursor(hand_open, Input.CURSOR_ARROW, Vector2(16,16))





func in_trash():
	for icon in get_tree().get_nodes_in_group("draggable"):
		if is_in_group("cmd_virus"):
			var instance = CMD2.instantiate()
			instance.z_index = 10 # making sure CMD2 appears above icons
			instance.position = Vector2(-120, -120) # positions the CMD2 popup 
			instance.visible = true
			add_child(instance)
#if the icon is in the cmd_virus group ⬆️ the second cmd message pops up 
			#play pop_in animation when instanced
			var anim_player = instance.get_node("AnimationPlayer")
			if anim_player:
				anim_player.play("pop_in")
		# Start timer to show blue screen after delay
			var timer = Timer.new()
			timer.wait_time = 5.0  # 5seconds
			timer.one_shot = true
			timer.timeout.connect(change_scene)
			add_child(timer)
			timer.start()
			game_timer.stop()  # stop the game_timer if the virus is found 
			# if the icon is the corrupted virus pop up the CMD2 and bluescreen


		elif icon == self:
			icon.queue_free() # delete the icon once the mouse is let go over the trashbin



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == trash_bin:
		is_overlapping = true
	Input.set_custom_mouse_cursor(hand_closed, Input.CURSOR_ARROW, Vector2(16,16))


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == trash_bin:
		is_overlapping = false
	Input.set_custom_mouse_cursor(hand_open, Input.CURSOR_ARROW, Vector2(16,16))



func change_scene():
		get_tree().change_scene_to_file("res://scenes/blue_screen.tscn")


func _on_button_mouse_entered() -> void:
	if not dragging:
		Input.set_custom_mouse_cursor(hand_open, Input.CURSOR_ARROW, Vector2(16,16))


func _on_button_mouse_exited() -> void:
	if not dragging and not is_overlapping:
		Input.set_custom_mouse_cursor(normal_cursor, Input.CURSOR_ARROW, Vector2(16,16))

# Input.set_custom_mouse_cursor(cursor_name, Input.CURSOR_ARROW, Vector2(16,16)) is changing the cursor based on what it is hovering or grabbing
