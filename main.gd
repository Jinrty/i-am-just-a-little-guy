extends Control


var possible_lines: Array = []
var suggestions: Array = []

var new_person = person.new()
var queue: Array = []

var speaking: bool = false
var skip: bool = false
var writing: bool = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip") and writing:
		skip = true


func _ready() -> void:
	var custom_font = preload("res://assets/Salmon Typewriter 9 Regular.ttf") 
	
	$Label.add_theme_font_override("font", custom_font)
	
	$LineEdit.add_theme_font_override("font", custom_font)

	$LineEdit.grab_focus()
	new_person.load_values(preload("uid://bymamdoams2ke"))
	possible_lines = new_person.lines.keys()
	possible_lines.append(new_person.correct_answer)
	for i in new_person.bad_answers:
		possible_lines.append(i)
		
	write(new_person.question)

func has_special_word(line: String) -> String:
	var placeholder = line
	for x in possible_lines:
		if line.contains(x):
			var index = placeholder.find(x)
			var tab = placeholder.split("")
			tab.insert(index, "[b]")
			tab.insert(index + x.length() + 1, "[/b]")
			placeholder = "".join(tab)
			return placeholder
		
	return line
	
				

func write(text: String):
	skip = false
	has_special_word(text)
	text = has_special_word(text)
	$Label.text = text
	$Label.visible_characters = 0
	for i in text.length():
		writing = true
		if skip:
			$Label.visible_characters = -1
			break
		$Label.visible_characters += 1
		await get_tree().create_timer(0.02).timeout
	skip = false
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
