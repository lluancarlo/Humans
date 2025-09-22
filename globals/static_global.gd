extends Node


const HUMANS_GROUP : String = "Human"

func connect_to_human_hover(function: Callable) -> void:
	for human in get_tree().get_nodes_in_group(StaticGlobal.HUMANS_GROUP) as Array[BasicCharacter]:
		human.event_hovered.connect(function)

func connect_to_human_selected(function: Callable) -> void:
	for human in get_tree().get_nodes_in_group(StaticGlobal.HUMANS_GROUP) as Array[BasicCharacter]:
		human.event_selected.connect(function)
