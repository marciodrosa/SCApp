extends PanelContainer


var person: SCPerson setget set_person


func _ready():
	pass


func set_person(p: SCPerson):
	person = p
	$MarginContainer/VBoxContainer/Header/NameLabel.text = person.name
	$MarginContainer/VBoxContainer/Header/PenaltySpinBox.value = person.penalty
	$MarginContainer/VBoxContainer/VotesContainer.person = person


func _on_PenaltySpinBox_value_changed(value):
	if person != null:
		person.penalty = value
