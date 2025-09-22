extends Node
class_name MouseController

@onready var _main_camera : Camera3D = %MainCamera

var current_hover_character : BasicCharacter

func _ready() -> void:
	StaticGlobal.connect_to_human_hover(_on_human_hovered)

func _on_human_hovered(character: BasicCharacter, hovered: bool) -> void:
	current_hover_character = character if hovered else null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				deselect_all()
				if current_hover_character:
					current_hover_character.select(true)
		
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				move_selected_character(event.position)

func deselect_all() -> void:
	for character in get_tree().get_nodes_in_group(StaticGlobal.HUMANS_GROUP) as Array[BasicCharacter]:
		character.select(false)

func move_selected_character(mouse_position: Vector2) -> void:
	for character in get_tree().get_nodes_in_group(StaticGlobal.HUMANS_GROUP) as Array[BasicCharacter]:
		if character.is_selected:
			var world_position = _get_world_position_from_mouse(mouse_position)
			if world_position != Vector3.ZERO:
				character.move(world_position)

func _get_world_position_from_mouse(mouse_position: Vector2) -> Vector3:
	var params = PhysicsRayQueryParameters3D.new()
	params.from = _main_camera.project_ray_origin(mouse_position)
	params.to = params.from + _main_camera.project_ray_normal(mouse_position) * 1000
	params.collision_mask = 1
	
	var space_state = _main_camera.get_world_3d().direct_space_state
	var result = space_state.intersect_ray(params)
	
	if result:
		return result.position
	else:
		return Vector3.ZERO
