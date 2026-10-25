extends Resource
class_name person_values

@export var image = preload("uid://dg2up3k17hyrd")
@export var person_name: String = ""
@export var question: String = ""
@export var correct_answer: String = ""
@export var bad_answers: Array[String] = []
@export var lines: Dictionary[String, Array] = {}
