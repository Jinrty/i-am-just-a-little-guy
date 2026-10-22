extends Node
class_name person


var person_name: String = "Mr Guy"
var lines: Array = [
	question.new("Do you know me?",
		[
		dialogue.new("yes", dialogue.answer_type.BAD, "Huh?"),
		dialogue.new("no", dialogue.answer_type.GOOD, "I must have imagined something"),
		dialogue.new("maybe", dialogue.answer_type.NEUTRAL, "Make up your mind!")
		]
		)
]
	
