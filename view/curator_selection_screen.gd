extends Control

var view_model: CuratorSelectionViewModel


func _ready():
	view_model = CuratorSelectionViewModel.new(AppState)
	view_model.ready()
	var curators_list = get_node("%CuratorsList")
	for curator_entry in view_model.curators_list:
		curators_list.add_item(curator_entry)
	curators_list.select(view_model.curators_list_selected_index)
	check_next_button_availability()


func _on_Footer_on_next():
	get_tree().change_scene_to_file(view_model.go_next())


func check_next_button_availability():
	get_node("%Toolbar").next_button_enabled = view_model.can_go_next


func _on_CuratorsList_item_selected(index):
	view_model.curators_list_selected_index = index
	check_next_button_availability()


func _on_toolbar_on_next():
	get_tree().change_scene_to_file(view_model.go_next())


func _on_toolbar_on_save():
	view_model.save()
