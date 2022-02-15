extends Control

# The person that owns the vote.
var person: SCPerson setget set_person


# The index of this entry / vote.
var vote_index: int setget set_vote_index


# Signal send when the user moves the vote up.
signal vote_moved_up(person, index)


# Signal send when the user moves the vote down.
signal vote_moved_down(person, index)


func set_person(p: SCPerson):
	person = p
	_refresh()


func set_vote_index(i: int):
	vote_index = i
	_refresh()


func _refresh():
	var movie_label = $PanelContainer/HBoxContainer/MovieLabel
	if person != null and vote_index >= 0 and vote_index < person.votes.size():
		movie_label.text = person.votes[vote_index]


func _on_UpButton_pressed():
	person.move_vote_up(vote_index)
	emit_signal("vote_moved_up", person, vote_index)


func _on_DownButton_pressed():
	person.move_vote_down(vote_index)
	emit_signal("vote_moved_down", person, vote_index)
