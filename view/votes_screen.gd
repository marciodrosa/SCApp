extends Control

var view_model: VotesViewModel


func _ready():
	view_model = VotesViewModel.new(AppState)
	var scroll_v_box = get_node("%ScrollVBox")
	for person_votes_view_model in view_model.votes:
		var person_votes_control = preload("res://view/person_votes_control.tscn").instantiate()
		person_votes_control.view_model = person_votes_view_model
		person_votes_control.connect("votes_changed",Callable(self,"_votes_changed"))
		scroll_v_box.add_child(person_votes_control)
	_refresh_footer()


func _votes_changed(value):
	_refresh_footer()


func _refresh_footer():
	get_node("%Toolbar").next_button_enabled = view_model.can_go_next


func _on_toolbar_on_back():
	get_tree().change_scene_to_file(view_model.go_back())


func _on_toolbar_on_next():
	get_tree().change_scene_to_file(view_model.go_next())


func _on_toolbar_on_save():
	view_model.save()
