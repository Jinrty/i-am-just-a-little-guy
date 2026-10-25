extends Node2D


func _ready() -> void:
	for x in 26:
		$Label.visible_characters += 1
		await get_tree().create_timer(0.06).timeout
	await get_tree().create_timer(3).timeout
	for x in 34:
		$Label.visible_characters += 1
		await get_tree().create_timer(0.06).timeout
