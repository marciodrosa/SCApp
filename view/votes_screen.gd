extends Control

var view_model: VotesViewModel


func _ready():
	view_model = VotesViewModel.new(AppState)
	var tab_container = get_node("%TabContainer")
	for person_votes_view_model in view_model.votes:
		var person_votes_control = preload(
			"res://view/person_votes_control.tscn"
		).instantiate()
		person_votes_control.view_model = person_votes_view_model
		person_votes_control.votes_changed.connect(_votes_changed)
		tab_container.add_child(person_votes_control)
		tab_container.set_tab_title(
			tab_container.get_child_count() - 1,
			person_votes_view_model.person_name
		)
	_refresh_footer()
	_refresh_tab_icons()


func _refresh_tab_icons():
	var tab_container = get_node("%TabContainer")
	var completed_icon = preload("res://view/icons/checkmark.png")
	var error_icon = preload("res://view/icons/cross.png")
	var warning_icon = preload("res://view/icons/warning.png")
	for i in tab_container.get_child_count():
		var person_view_model = view_model.votes[i]
		var icon = null
		match person_view_model.state:
			VotesViewModel.VoteViewModel.State.COMPLETED:
				icon = completed_icon
			VotesViewModel.VoteViewModel.State.ERROR:
				icon = error_icon
			VotesViewModel.VoteViewModel.State.WARNING:
				icon = warning_icon
		tab_container.set_tab_icon(i, icon)


func _votes_changed(value):
	_refresh_footer()
	_refresh_tab_icons()


func _refresh_footer():
	get_node("%Toolbar").next_button_enabled = view_model.can_go_next


func _on_toolbar_on_back():
	get_tree().change_scene_to_file(view_model.go_back())


func _on_toolbar_on_next():
	get_tree().change_scene_to_file(view_model.go_next())


func _on_toolbar_on_save():
	view_model.save()
