extends Reference

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
	
# Returns a string representation of the votes, including the name of the person
# and the name of the movies.
func votes_to_string() -> String:
	var result = name + ":"
	for i in range(votes.size()):
		result += "\n" + String(i + 1) + " - " + votes[i]
	return result


# Convenience function to move up the vote at the given index in the votes array.
func move_vote_up(index: int):
	swap_votes(index, index - 1)


# Convenience function to move down the vote at the given index in the votes array.
func move_vote_down(index: int):
	swap_votes(index, index + 1)


func swap_votes(index1: int, index2: int):
	if index1 >= 0 and index1 < votes.size() and index2 >= 0 and index2 < votes.size():
		var temp = votes[index1]
		votes[index1] = votes[index2]
		votes[index2] = temp
