extends Control

var possible_inputs = ["rock", "knife", "glass"]

var new_person = person.new()


func _ready() -> void:
	$LineEdit.grab_focus()
	new_person.person_name = "Detective Kim"
	print(new_person.lines[0])


func _on_line_edit_text_submitted(new_text: String) -> void:
	$LineEdit.text = ""
	$LineEdit.grab_focus()
	if new_text.is_empty():
		print("hell nah")
	elif not possible_inputs.has(new_text):
		print("nope")
	elif possible_inputs.has(new_text):
		print("yeah")
	
	$LineEdit.release_focus()
	$LineEdit.call_deferred("grab_focus")
