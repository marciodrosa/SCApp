extends PanelContainer


var person: SCPerson setget set_person


func _ready():
	pass


func set_person(p: SCPerson):
	person = p
	$MarginContainer/VBoxContainer/Header/NameLabel.text = person.name
	$MarginContainer/VBoxContainer/Header/PenaltySpinBox.value = person.penalty
	var votes_container = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VotesContainer
	for i in range(person.votes.size()):
		var vote_entry = preload("res://scenes/vote_entry.tscn").instance()
		vote_entry.person = person
		vote_entry.vote_index = i
		vote_entry.connect("vote_moved_down", self, "_vote_up_or_down")
		vote_entry.connect("vote_moved_up", self, "_vote_up_or_down")
		votes_container.add_child(vote_entry)


func _on_PenaltySpinBox_value_changed(value):
	if person != null:
		person.penalty = value


func _vote_up_or_down(person, index):
	var votes_container = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VotesContainer
	for i in range(votes_container.get_child_count()):
		var vote_entry = votes_container.get_child(i)
		vote_entry.vote_index = i
