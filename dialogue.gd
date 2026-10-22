extends Node
class_name dialogue

enum answer_type {
	GOOD,
	NEUTRAL,
	BAD
}
var answer: String = "someting"
var type: answer_type = answer_type.GOOD
var result : String = "What???"

func _init(temp_answer: String, temp_type: answer_type, temp_result:String) -> void:
	answer = temp_answer
	type = temp_type
	result = temp_result
