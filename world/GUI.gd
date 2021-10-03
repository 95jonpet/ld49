class_name GUI
extends CanvasLayer

var score: int = 0 setget set_score
onready var score_label: Label = get_node("ScoreLabel")

func add_score(score_increment: int) -> void:
	assert(score_increment > 0)
	self.score += score_increment


func set_score(value: int) -> void:
	assert(value >= 0)
	score = value
	score_label.text = "Score: " + str(score)
