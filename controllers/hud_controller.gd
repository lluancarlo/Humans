extends Node
class_name HudController

@export var label_name : Label

func _ready() -> void:
	StaticGlobal.connect_to_human_selected(_on_human_selected)

func _on_human_selected(char: BasicCharacter) -> void:
	label_name.text = char.name
