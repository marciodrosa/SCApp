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
