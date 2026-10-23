extends Control


@export_file("*.tscn") var game_scene_path: String


func _on_play_button_pressed() -> void:
	if game_scene_path != "res://main.tscn":
		get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
