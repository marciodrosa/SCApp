extends RefCounted

# A person of the SC, can be a voter or the current curator.
class_name SCPerson

# The name of the person
var name = ""

# The votes of the person, sorted by preference.
var votes = []

# The penalty the person has to be subtracted from the value each vote has. Zero
# means no penalty, 1 means a small penalty, 6 means a big penalty.
var penalty = 0

# The votes as string, each one in one line.
var votes_as_string_list: String:
	get:
		var result = ""
		for vote in votes:
			if result.length() > 0:
				result += "\n"
			result += vote
		return result
	set(value):
		votes = value.split("\n", false)


func _init(name = ""):
	self.name = name


# Returns a string representation of the votes, including the name of the person
# and the name of the movies.
func result_votes_to_string() -> String:
	var result = name
	if penalty > 0:
		result += " (-%d pontos)" % penalty
	result += ":"
	for v in votes:
		result += "\n" + v
	return result

