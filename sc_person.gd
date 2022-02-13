extends Resource

# A person of the SC, can be a voter or the current curator.
class_name SCPerson
	
# The name of the person
var name = ""

# Array with the names of the movies the person voted for, sorted by preference.
var votes = []

# The penalty the person has to be subtracted from the value each vote has. Zero
# means no penalty, 1 means a small penalty, 6 means a big penalty.
var penalty = 0

func _init(name = ""):
	self.name = name
