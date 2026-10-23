extends Control

var possible_lines: Array = []

var new_person = person.new()
var queue: Array = []

var speaking: bool = false
var skip: bool = false
var writing: bool = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip") and writing:
		skip = true


func _ready() -> void:
	$LineEdit.grab_focus()
	new_person.load_values(preload("uid://bymamdoams2ke"))
	possible_lines = new_person.lines.keys()
	possible_lines.append(new_person.correct_answer)
	for i in new_person.bad_answers:
		possible_lines.append(i)
	print(new_person.lines)


func write(text: String):
	await get_tree().process_frame
	$Label.text = ""
	speaking = true
	skip = false
	for i in text.length():
		writing = true
		if skip:
			$Label.text = text
			break
		$Label.text += text[i]
		await get_tree().create_timer(0.02).timeout
	skip = false
	speaking = false
	writing = false
	
	if queue.size() == 0:
		return
	
	if text == queue[0]:
		queue.pop_front()
		if queue.size() > 0:
			await get_tree().create_timer(1.5).timeout
			write(queue[0])


func _on_line_edit_text_submitted(new_text: String) -> void:
	$LineEdit.text = ""
	$LineEdit.grab_focus()
	skip = false
	var line = new_text.to_lower()
	if new_text.is_empty():
		print("empty")
	elif not possible_lines.has(line):
		write("Sorry I didn't hear that...")
	elif possible_lines.has(line):
		if new_person.correct_answer == line:
			write("How could I suspect you! You are just a little guy!")
		elif new_person.bad_answers.has(line):
			write("What? How could a little guy like you kill someone!")
		else:
			queue += new_person.lines[line]
			write(queue[0])
	
	$LineEdit.release_focus()
	$LineEdit.call_deferred("grab_focus")
