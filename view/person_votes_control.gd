extends MarginContainer

signal penalty_changed(value)
signal votes_changed(value)

var view_model: VotesViewModel.VoteViewModel : set = _set_view_model


func _set_view_model(vm):
	view_model = vm
	get_node("%NameLabel").text = view_model.person_name
	get_node("%PenaltySpinBox").value = view_model.penalty
	get_node("%VotesEdit").text = view_model.votes
	_refresh_validation()


func _refresh_validation():
	get_node("%VotesConference").text = view_model.validated_movies
	get_node("%ErrorMessage").visible = !view_model.are_votes_valid
	get_node("%ErrorMessage").text = view_model.error_message


func _on_SaveButton_pressed():
	view_model.save()


func _on_votes_edit_text_changed():
	var new_value = get_node("%VotesEdit").text
	view_model.votes = new_value
	_refresh_validation()
	votes_changed.emit(new_value)


func _on_penalty_spin_box_value_changed(value):
	view_model.penalty = value
	penalty_changed.emit(value)
