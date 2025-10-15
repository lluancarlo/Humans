extends CharacterBody3D
class_name BasicCharacter

@export var _hover_material : Material
@export var _look_speed : float = 6
@export var _move_speed : float = 1.5

@onready var _main_camera : Camera3D = %MainCamera
@onready var _nav_agent : NavigationAgent3D = $NavigationAgent3D
@onready var _skeleton : Skeleton3D = $Character/Armature/GeneralSkeleton
@onready var _selection_effect : Node3D = $SelectedEffect
@onready var _anim_tree : AnimationTree = $Character/AnimationTree

signal event_hovered(char: BasicCharacter, hovered: bool)
signal event_selected(char: BasicCharacter)

const selection_pivot_offset : Vector3 = Vector3(0.0, 1, 0.0)

var is_selected : bool
var current_target_position : Vector3
var current_animation_index : int

func _ready() -> void:
	select(false)

func _physics_process(delta: float) -> void:
	if current_target_position.length() != 0:
		var next_pos = _nav_agent.get_next_path_position() as Vector3
		var new_velocity: Vector3 = global_position.direction_to(next_pos) * _move_speed
		
		_nav_agent.set_velocity(new_velocity)
		move_and_slide()
		
		var dir = next_pos - _skeleton.global_transform.origin
		if dir.length() > 0.1:
			set_animation(1)
			var target_angle = atan2(dir.x, dir.z) - PI/2
			rotation.y = lerp_angle(rotation.y, target_angle, delta * _look_speed)
		else:
			set_animation(0)
		

func select(selected: bool) -> void:
	is_selected = selected
	_selection_effect.visible = selected
	if selected:
		event_selected.emit(self)

func hover(hovered: bool) -> void:
	for mesh in _skeleton.get_children():
		mesh.material_override = _hover_material if hovered else null

func set_animation(index: int) -> void:
	if index == 0 && current_animation_index != 0:
		_anim_tree.set("parameters/conditions/is_idling", true)
		_anim_tree.set("parameters/conditions/is_walking", false)
		current_animation_index = index
	elif index == 1 && current_animation_index != 1:
		_anim_tree.set("parameters/conditions/is_idling", false)
		_anim_tree.set("parameters/conditions/is_walking", true)
		current_animation_index = index

func get_position_on_camera() -> Vector2:
	return _main_camera.unproject_position(self.global_transform.origin + selection_pivot_offset)

func move(target_position: Vector3) -> void:
	current_target_position = target_position
	_nav_agent.set_target_position(target_position)
	DebugGlobal.spawn_temporary_3d_spot(target_position)

func _on_area_3d_mouse_entered() -> void:
	hover(true)
	event_hovered.emit(self, true)

func _on_area_3d_mouse_exited() -> void:
	hover(false)
	event_hovered.emit(self, false)

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity


func _on_navigation_agent_3d_target_reached() -> void:
	current_target_position = Vector3.ZERO
