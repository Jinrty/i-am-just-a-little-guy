extends Control

var possible_lines: Array = []

var x: Array[String] = ["ss", "rd"]

var new_person = person.new()


func _ready() -> void:
	$LineEdit.grab_focus()
	new_person.person_name = "Detective Kim"
	possible_lines = new_person.lines.keys()
	possible_lines.append(new_person.correct_answer)
	for i in new_person.bad_answers:
		possible_lines.append(i)
	print(possible_lines)




func _on_line_edit_text_submitted(new_text: String) -> void:
	$LineEdit.text = ""
	$LineEdit.grab_focus()
	if new_text.is_empty():
		print("empty")
	elif not possible_lines.has(new_text.to_lower()):
		print("Umm...")
	elif possible_lines.has(new_text.to_lower()):
		print(new_person.lines[new_text])
	
	
	$LineEdit.release_focus()
	$LineEdit.call_deferred("grab_focus")
