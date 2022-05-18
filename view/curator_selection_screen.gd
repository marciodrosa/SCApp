extends Control

var view_model: CuratorSelectionViewModel


func _ready():
	view_model = CuratorSelectionViewModel.new(AppState)
	view_model.ready()
	var curators_list = $VBoxContainer/MarginContainer/VBoxContainer/CuratorsList
	for curator_entry in view_model.curators_list:
		curators_list.add_item(curator_entry)
	curators_list.select(view_model.curators_list_selected_index)
	check_next_button_availability()


func _on_Footer_on_next():
	get_tree().change_scene(view_model.go_next())


func check_next_button_availability():
	var footer = $VBoxContainer/Footer
	footer.next_button_enabled = view_model.can_go_next


func _on_CuratorsList_item_selected(index):
	view_model.curators_list_selected_index = index
	check_next_button_availability()
