extends Node
#class_name Debug

func spawn_temporary_2d_spot(position: Vector2, lifetime: float = 3.0) -> void:
	var panel = Panel.new()
	add_child(panel)
	panel.modulate = Color.RED
	panel.size = Vector2(10, 10)
	panel.position = position
	create_tween().tween_callback(panel.queue_free).set_delay(lifetime)
	
	print("Spawning 2D spot on: " + str(position))
	
func spawn_temporary_3d_spot(position: Vector3, lifetime: float = 2.0) -> void:
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	
	var box_3d = BoxMesh.new()
	box_3d.material = material
	box_3d.size = Vector3(0.25, 0.25, 0.25)
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = box_3d
	mesh_instance.position = position
	add_child(mesh_instance)
	
	create_tween().tween_callback(mesh_instance.queue_free).set_delay(lifetime)
	
	print("Spawning 3D spot on: " + str(position))
