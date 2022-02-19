extends Reference

# Class with functions that can be used to save and load SCData objects.
class_name SCDataIO


# Saves the given data in a JSON file in the user folder.
func save_data(data: SCData):
	var file = open_file(File.WRITE)
	var json = to_json(data.to_dictionary())
	file.store_string(json)
	file.close()


# Loads the data from the default JSON file in the user folder. Returns a new default object if fails.
func load_data() -> SCData:
	var data = SCData.new()
	var file = open_file(File.READ)
	var json = file.get_as_text()
	var dictionary = parse_json(json)
	if typeof(dictionary) == TYPE_DICTIONARY:
		data.from_dictionary(dictionary)
	file.close()
	return data


func open_file(mode) -> File:
	var file = File.new()
	file.open("user://SCData.json", mode)
	return file
