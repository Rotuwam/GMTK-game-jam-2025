extends Node2D


@onready var object: Sprite2D = $Object
@onready var button: Button = $Button

var dragging = false
var of = Vector2(0,0)



func _ready():
	if not button.button_down.is_connected(_on_button_button_down):
		button.button_down.connect(_on_button_button_down)
	if not button.button_up.is_connected(_on_button_button_up):
		button.button_up.connect(_on_button_button_up)

func _process(_delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position
	print("Started dragging:", name)
	dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	
