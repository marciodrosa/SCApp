@tool
extends Control

var _model: TestModel
var _runner: TestRunner
var _tests_tree: Tree
var _failed_only_check_button: CheckButton
var _tests_passed_label: Label
var _tests_failed_label: Label

func _ready():
	_tests_tree = get_node("%TestsTree")
	_failed_only_check_button = get_node("%FailedOnlyCheckButton")
	_tests_passed_label = get_node("%TestsPassedLabel")
	_tests_failed_label = get_node("%TestsFailedLabel")
	_runner = TestRunner.new()
	add_child(_runner)
	_play()


func _play():
	_model = TestModel.new(TestSeeker.new().seek_scripts())
	_init_tree()
	_runner.run(_model)
	_refresh_ui()


func _on_play_button_pressed():
	_play()


func _init_tree():
	_tests_tree.clear()
	_tests_tree.create_item()
	for test in _model.test_classes:
		var class_item = _tests_tree.create_item()
		class_item.set_text(0, test.name)
		class_item.set_metadata(0, test)
		for function in test.functions:
			var function_item = class_item.create_child()
			function_item.set_text(0, function.name)
			function_item.set_metadata(0, function)


func _refresh_ui():
	var root = _tests_tree.get_root()
	for class_item in root.get_children():
		_refresh_class_item(class_item)
	_tests_passed_label.text = "%s Tests Passed" % str(_count_tests_by_state(
		TestModel.State.PASSED
	))
	_tests_failed_label.text = "%s Tests Failed" % str(_count_tests_by_state(
		TestModel.State.FAILED
	))


func _refresh_class_item(class_item: TreeItem):
	var test_class = class_item.get_metadata(0) as TestModel.TestClass
	_set_visual_by_state(class_item, test_class.state)
	_set_visibility_by_state(class_item, test_class.state)
	for function_item in class_item.get_children():
		_refresh_function_item(function_item)


func _refresh_function_item(function_item: TreeItem):
	var test_function = (
		function_item.get_metadata(0) as TestModel.TestFunction
	)
	_set_visual_by_state(function_item, test_function.state)
	_set_visibility_by_state(function_item, test_function.state)
	var current_assert_items = function_item.get_children()
	for current_assert_item in current_assert_items:
		current_assert_item.free()
	for test_assert in test_function.asserts:
		_add_assert_item(test_assert, function_item)


func _add_assert_item(
		test_assert: TestModel.TestAssertResult,
		function_item: TreeItem):
	var assert_item = _tests_tree.create_item(function_item)
	assert_item.set_text(0, test_assert.message)
	assert_item.set_metadata(0, test_assert)
	_set_visual_by_passed(assert_item, test_assert.passed)


func _set_visual_by_state(tree_item: TreeItem, state: int):
	match state:
		TestModel.State.PASSED, TestModel.State.FAILED:
			_set_visual_by_passed(tree_item, state == TestModel.State.PASSED)


func _set_visual_by_passed(tree_item: TreeItem, passed: bool):
	if passed:
		tree_item.set_custom_color(0, Color.GREEN)
	else:
		tree_item.set_custom_color(0, Color.RED)
	tree_item.visible = true


func _set_visibility_by_state(tree_item: TreeItem, state: int):
	var failed_only = _failed_only_check_button.button_pressed
	if failed_only and state != TestModel.State.FAILED:
		tree_item.visible = false


func _on_failed_only_check_button_toggled(button_pressed):
	_refresh_ui()


func _count_tests_by_state(state: int) -> int:
	var count = 0
	for test_class in _model.test_classes:
		for test_function in test_class.functions:
			if test_function.state == state:
				count += 1
	return count

