@tool
extends EditorPlugin

var _tests_button: Button


func _enter_tree():
	_tests_button = Button.new()
	_tests_button.text = "Test"
	_tests_button.pressed.connect(_run_tests)
	add_control_to_container(
		CustomControlContainer.CONTAINER_TOOLBAR,
		_tests_button)


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, _tests_button)


func _run_tests():
	get_editor_interface().play_custom_scene(
		"res://addons/unit_test/test_gui.tscn"
	)
