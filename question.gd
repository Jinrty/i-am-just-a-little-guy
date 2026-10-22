extends Node
class_name question

var question_text : String = ""
var poss : Array[dialogue]

func _init(temp_question: String, temp_poss: Array[dialogue]) -> void:
	question_text = temp_question
	poss = temp_poss
