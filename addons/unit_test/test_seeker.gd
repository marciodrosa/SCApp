@tool
class_name TestSeeker

func seek_scripts() -> Array[String]:
	var result: Array[String] = []
	var root_tests_dir = DirAccess.open("res://tests")
	_seek_scripts_in_dir(root_tests_dir, result)
	return result


func _seek_scripts_in_dir(dir: DirAccess, out_array: Array[String]):
	var inner_dirs = dir.get_directories()
	for inner_dir_name in inner_dirs:
		var inner_dir = DirAccess.open(
			dir.get_current_dir().path_join(inner_dir_name)
		)
		_seek_scripts_in_dir(inner_dir, out_array)
	for file_name in dir.get_files():
		if file_name.ends_with(".gd"):
			var file_path = dir.get_current_dir().path_join(file_name)
			out_array.append(file_path)
