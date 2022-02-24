extends Control

class_name VoteEntry

# The person that owns the vote.
var person: SCPerson setget set_person


# The index of this entry / vote.
var vote_index: int setget set_vote_index


var _dragging = false


# Emitted when the user starts dragging the vote cell.
signal vote_drag_started(control)


# Emitted when the user ends dragging the vote cell.
signal vote_drag_ended(control)


func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		_dragging = true
		emit_signal("vote_drag_started", self)


func _input(event):
	if event is InputEventMouseButton and !event.is_pressed() and _dragging:
		_dragging = false
		emit_signal("vote_drag_ended", self)


func _ready():
	_refresh()

	
func set_person(p: SCPerson):
	person = p
	_refresh()


func set_vote_index(i: int):
	vote_index = i
	_refresh()


func _refresh():
	var movie_label = $PanelContainer/HBoxContainer/MovieLabel
	if movie_label != null and person != null and vote_index >= 0 and vote_index < person.votes.size():
		movie_label.text = person.votes[vote_index]
