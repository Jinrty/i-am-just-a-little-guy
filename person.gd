extends Node
class_name person


var person_name: String = "Mr Guy"
var lines: Array = [
	{"Are you sane? then type 'A'" : [
		dialogue.new(["a", "A"], dialogue.answer_type.GOOD, "Good"),
	]},
]
	
