extends Control

const detective = preload("uid://bymamdoams2ke")
const mayor = preload("uid://dghn346r4sd0x")
const lady = preload("uid://b11fcqv3cr5m1")

var hints: Array = []
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

func set_character(char: Resource) -> void:
	$Label.text = ""
	new_person.load_values(char)
	possible_lines = new_person.lines.keys()
	possible_lines.append(new_person.correct_answer)
	$CharName.visible_characters = 0
	$CharName.text = new_person.person_name
	for i in $CharName.text.length():
		$CharName.visible_characters += 1
		await get_tree().create_timer(0.04).timeout
	write(new_person.question)

func _ready() -> void:
	var custom_font = preload("res://assets/Salmon Typewriter 9 Regular.ttf") 
	$Label.add_theme_font_override("font", custom_font)
	$LineEdit.add_theme_font_override("font", custom_font)
	$LineEdit.grab_focus()
	set_character(detective)

func has_special_word(line: String) -> String:
	var placeholder = line.to_lower()
	var smth = line
	for x in possible_lines:
		if placeholder.contains(x):
			var index = placeholder.find(x)
			var tab = smth.split("")
			var tab2 = placeholder.split("")
			tab.insert(index, "[b]")
			tab.insert(index + x.length() + 1, "[/b]")
			tab2.insert(index, "[b]")
			tab2.insert(index + x.length() + 1, "[/b]")
			smth = "".join(tab)
			placeholder = "".join(tab2)
			if not hints.has(x):
				hints.push_back(x)
	return smth

	
				

func write(text: String):
	skip = false
	var imp = text
	text = has_special_word(text)
	$Label.text = text
	$Label.visible_characters = 0
	for i in text.length():
		writing = true
		if skip:
			$Label.visible_characters = -1
			break
		$Label.visible_characters += 1
		await get_tree().create_timer(0.02).timeout  #later do 0.02
	skip = false
	writing = false
	
	if queue.size() == 0:
		return
	
	if imp == queue[0]:
		queue.pop_front()
		if queue.size() > 0:
			await get_tree().create_timer(1.8).timeout
			write(queue[0])
		else:
			$LineEdit.call_deferred("grab_focus")
	
	


func _on_line_edit_text_submitted(new_text: String) -> void:
	new_text = new_text.strip_edges(true, true)
	new_text = new_text.trim_suffix("?")
	$LineEdit.text = ""
	$LineEdit.grab_focus()
	skip = false
	var line = new_text.to_lower()
	if new_text.is_empty():
		print("empty")
	elif not possible_lines.has(line):
		write("Sorry I didn't hear that...")
	elif possible_lines.has(line):
		#if new_person.correct_answer == line:
		#	write("How could I suspect you! You are just a little guy!")
		if new_person.bad_answers.has(line):
			write("What? How could a little guy like you kill someone!")
		else:
			queue += new_person.lines[line]
			write(queue[0])
	
	$LineEdit.release_focus()
	


func _on_to_detective_pressed() -> void:
	set_character(detective)


func _on_to_mayor_pressed() -> void:
	set_character(mayor)


func _on_to_lady_pressed() -> void:
	set_character(lady)


func _on_button_pressed() -> void:
	var temp_arr: Array = []
	#for x in hints:
	#	if possible_lines.has(x):
	#		temp_arr.append(x)
	#print(temp_arr)
