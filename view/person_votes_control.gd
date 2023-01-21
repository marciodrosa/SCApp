extends PanelContainer

signal penalty_changed(value)
signal votes_changed(value)

var view_model: VotesViewModel.VoteViewModel : set = _set_view_model


func _ready():
	pass


func _on_PenaltySpinBox_value_changed(value):
	view_model.penalty = value
	emit_signal("penalty_changed", value)


func _on_VotesEdit_text_changed():
	var new_value = $MarginContainer/VBoxContainer/HBoxContainer/VotesEdit.text
	view_model.votes = new_value
	_refresh_validation()
	emit_signal("votes_changed", new_value)


func _set_view_model(vm):
	view_model = vm
	$MarginContainer/VBoxContainer/Header/NameLabel.text = view_model.person_name
	$MarginContainer/VBoxContainer/Header/PenaltySpinBox.value = view_model.penalty
	$MarginContainer/VBoxContainer/HBoxContainer/VotesEdit.text = view_model.votes
	_refresh_validation()


func _refresh_validation():
	$MarginContainer/VBoxContainer/HBoxContainer/VotesConferenceMargin/VotesConference.text = view_model.validated_movies
	$MarginContainer/VBoxContainer/ErrorMessage.visible = !view_model.are_votes_valid
	$MarginContainer/VBoxContainer/ErrorMessage.text = view_model.error_message


func _on_SaveButton_pressed():
	view_model.save()
