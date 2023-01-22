@tool
class_name TestRunner extends Node


func run(model: TestModel):
	for c in model.test_classes:
		c.state = TestModel.State.RUNNING
		for f in c.functions:
			_run_test_function(c, f)
		_refresh_class_state(c)


func _run_test_function(c: TestModel.TestClass, f: TestModel.TestFunction):
	f.state = TestModel.State.RUNNING
	f.asserts = []
	var done = false
	var params_setted_on_function = null
	var params_setted_on_function_index = 0
	while not done:
		var class_instance = c.script_resource.new()
		class_instance._parameters = params_setted_on_function
		class_instance._params_index = params_setted_on_function_index
		class_instance._refresh_p()
		add_child(class_instance)
		class_instance.pre()
		class_instance.call(f.name)
		params_setted_on_function = class_instance._parameters
		params_setted_on_function_index = class_instance._params_index
		class_instance.post()
		remove_child(class_instance)
		f.asserts.append_array(class_instance.asserts.results)
		_refresh_function_state(f)
		class_instance.queue_free()
		if params_setted_on_function != null:
			params_setted_on_function_index += 1
			if params_setted_on_function_index >= params_setted_on_function.size():
				done = true
		else:
			done = true


func _refresh_function_state(f: TestModel.TestFunction):
	var failed = false
	for assert_result in f.asserts:
		if not assert_result.passed:
			failed = true
			break
	if failed:
		f.state = TestModel.State.FAILED
	else:
		f.state = TestModel.State.PASSED


func _refresh_class_state(c: TestModel.TestClass):
	var failed = false
	for f in c.functions:
		if f.state == TestModel.State.FAILED:
			failed = true
			break
	if failed:
		c.state = TestModel.State.FAILED
	else:
		c.state = TestModel.State.PASSED
