extends Reference

# Contains data with the results of the votes.
class_name SCResult

# List of the names of the movies that have been choosen. Usually should be only one, but may be more
# in case of a tie.
var choosen_movies = []

# Flag indicating that the vote results in a tie between more than one movie. In this case,
# choosen_movies will have more than one element.
var tie = false

# Dictionary with the votes, where the key is the name of the movie and the value is the number of
# votes it had.
var votes = {}

func _init(data: SCData):
	pass
