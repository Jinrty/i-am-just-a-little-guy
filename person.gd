extends Node
class_name person


var person_name: String = "Mr Guy"
var question: String = "Do you know me?"
var correct_answer: String = "no"
var bad_answers: Array[String] = ["yes", "poop"]
var lines: Dictionary[String, Array] = {}
	
func load_values(res: Resource):
	person_name = res.person_name
	question = res.question
	correct_answer = res.correct_answer
	bad_answers = res.bad_answers
	lines = res.lines
