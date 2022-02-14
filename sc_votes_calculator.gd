extends Reference
# Object responsible to calculate the results of a SC.
class_name SCVotesCalculator


# Returns the number of points the movie should receive given the position in the list of a person
# (starting from 0), the total number of movies that is available to vote, and the penalty the person
# has.
func convert_vote_to_points(vote_position: int, number_of_movies: int, penalty = 0) -> int:
	var result = number_of_movies - vote_position
	if penalty > 0:
		var adjusted_penalty = clamp(penalty - vote_position, 0, penalty)
		result -= adjusted_penalty
	return clamp(result, 1, number_of_movies) as int


# Returns a dictionary with the votes of the given person, where the keys are the name of the movies
# and the values are the amount of votes (points) the movie had.
func calculate_votes_of_a_person(person: SCPerson) -> Dictionary:
	var result = {}
	for i in range(person.votes.size()):
		var movie = person.votes[i]
		var vote_points = convert_vote_to_points(i, person.votes.size(), person.penalty)
		result[movie] = vote_points
	return result


# Returns a new dictionary where the key is the name of the movie and the value is the number of votes
# by joining two given dictionaries (it is assumed they have the same keys).
func join_votes(votes1: Dictionary, votes2: Dictionary) -> Dictionary:
	var result = {}
	for movie in votes1:
		result[movie] = votes1[movie] + (votes2[movie] if votes2.has(movie) else 0)
	return result


# Returns a dictionary with the votes of all people in the given array of SCPerson objects, where the
# keys are the name of the movies and the values are the amount of votes (points) the movie had.
func calculate_votes_of_people(people: Array) -> Dictionary:
	var result = {}
	for person in people:
		result = join_votes(calculate_votes_of_a_person(person), result)
	return result


# Class used internally by the function get_movies_sorted_by_votes.
class _MovieSorter:
	var votes: Dictionary
	func sort(movie1, movie2) -> bool:
		return votes[movie1] > votes[movie2]


# Returns the list of movies names (array of strings) sorted by the number of votes, given a dictionary
# where the keys are the name of the movies and the values are the number of votes it has.
func get_movies_sorted_by_votes(votes: Dictionary) -> Array:
	var sorter = _MovieSorter.new()
	sorter.votes = votes
	var movies_list = votes.keys()
	movies_list.sort_custom(sorter, "sort")
	return movies_list
