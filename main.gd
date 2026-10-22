extends Control

var possible_inputs = []

var new_person = person.new()


func _ready() -> void:
	$LineEdit.grab_focus()
	new_person.person_name = "Detective Kim"
	print(new_person.lines[0].question_text)
	print(new_person.lines[0].poss[0].answer)
	for i in new_person.lines[0].poss.size():
		possible_inputs.append(new_person.lines[0].poss[i].answer)
	print(possible_inputs)




func _on_line_edit_text_submitted(new_text: String) -> void:
	$LineEdit.text = ""
	$LineEdit.grab_focus()
	if new_text.is_empty():
		print("empty")
	elif possible_inputs.has(new_text.to_lower()):
		print(new_person.lines[0].poss[1].result)
	elif not possible_inputs.has(new_text):
		print("Umm...")
	
	
	$LineEdit.release_focus()
	$LineEdit.call_deferred("grab_focus")
