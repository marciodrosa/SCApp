extends RefCounted

# Class with functions that can be used to save and load SCData objects.
class_name SCDataService


# Saves the given data in a JSON file in the user folder.
func save_data(data: SCData):
	var file = open_file(FileAccess.WRITE)
	var json = JSON.new().stringify(data.to_dictionary())
	file.store_string(json)


# Loads the data from the default JSON file in the user folder. Returns a new default object if fails.
func load_data() -> SCData:
	var data = SCData.new()
	var file = open_file(FileAccess.READ)
	var json = file.get_as_text()
	var test_json_conv = JSON.new()
	test_json_conv.parse(json)
	var dictionary = test_json_conv.get_data()
	if typeof(dictionary) == TYPE_DICTIONARY:
		data.from_dictionary(dictionary)
	return data


func open_file(mode) -> FileAccess:
	return FileAccess.open("user://SCData.json", mode)
