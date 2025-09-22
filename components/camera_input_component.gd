extends Node
class_name CameraInputComponent

@export_category("Nodes")
@export var pivot : Node3D
@export_category("Variables")
@export var smoothness : float = 5.0
@export var move_speed : float = 10
@export var rotation_speed : float = 2.0
@export var zoom_speed : float = 1.0
@export var max_zoom_in : float = 2.0
@export var max_zoom_out : float = 10.0

@onready var main_camera := %MainCamera as Camera3D
@onready var target_zoom := main_camera.position.z

var target_position: Vector3
var target_angle: float
var is_holding_mouse_right: float
var mouse_rotate_input: float

func _ready():
	target_position = pivot.global_position
	target_angle = pivot.global_rotation.y

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and\
			main_camera.position.z > max_zoom_in:
			target_zoom = max(target_zoom - zoom_speed, max_zoom_in)
		
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and\
			main_camera.position.z < max_zoom_out:
			target_zoom = min(target_zoom + zoom_speed, max_zoom_out)
		
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			is_holding_mouse_right = event.is_pressed()
	
	elif event is InputEventMouseMotion and is_holding_mouse_right:
		mouse_rotate_input = -event.relative.x * 0.1

func _physics_process(delta: float) -> void:
	# zoom
	var current_z = main_camera.position.z
	main_camera.position.z = lerp(current_z, target_zoom, smoothness * delta)
	
	# rotation
	var rotate = Input.get_axis("rotate_left", "rotate_right") + mouse_rotate_input
	if rotate != 0:
		target_angle += rotate * rotation_speed * delta

	pivot.global_rotation.y = lerp_angle(pivot.global_rotation.y, target_angle, smoothness * delta)

	# movement
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("down", "up")

	var forward = -main_camera.global_transform.basis.z
	forward.y = 0.0

	var right = main_camera.global_transform.basis.x
	right.y = 0.0

	var move_dir = (forward * vertical).normalized() + (right * horizontal)

	if move_dir != Vector3.ZERO:
		move_dir = move_dir.normalized()
		target_position += move_dir * move_speed * delta

	pivot.global_position.x = lerp(pivot.global_position.x, target_position.x, smoothness * delta)
	pivot.global_position.z = lerp(pivot.global_position.z, target_position.z, smoothness * delta)
	
	mouse_rotate_input = 0.0
