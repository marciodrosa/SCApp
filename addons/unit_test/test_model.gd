@tool
class_name TestModel


enum State { NOT_STARTED, RUNNING, PASSED, FAILED }


class TestAssertResult:
	var message: String
	var passed: bool


class TestFunction:
	var name: String
	var state: State = State.NOT_STARTED
	var asserts: Array[TestAssertResult] = []


class TestClass:
	var name: String
	var script_path: String
	var script_resource: GDScript
	var state: State = State.NOT_STARTED
	var functions: Array[TestFunction] = []


var test_classes: Array[TestClass] = []


func _init(scripts: Array[String]):
	for script_path in scripts:
		var script = load(script_path)
		if not script is GDScript:
			continue
		var instance = script.new()
		if instance is TestCase:
			var tc = _create_test_class_model(script, script_path)
			test_classes.append(tc)


func _create_test_class_model(script: GDScript, script_path: String) -> TestClass:
	var tc = TestClass.new()
	tc.name = script_path
	tc.script_path = script_path
	tc.script_resource = script
	var methods = script.get_script_method_list()
	tc.functions = _create_test_function_models(methods)
	return tc


func _create_test_function_models(methods: Array) -> Array[TestFunction]:
	var result: Array[TestFunction] = []
	for method in methods:
		if method.name.begins_with("test_") and method.args.size() == 0:
			var tf = TestFunction.new()
			tf.name = method.name
			result.append(tf)
	return result
