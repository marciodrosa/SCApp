extends WATTest

var person: SCPerson

func pre():
	person = SCPerson.new("John")


func test_should_initialize():
	asserts.is_equal(person.name, "John")
	asserts.is_equal(person.penalty, 0)
	asserts.is_equal(person.votes, "")


func test_should_set_votes_as_string():
	# given:
	person.votes_as_string_list = "Bound\nCría Cuervos\n\nBad Luck Banging or Loony Porn"
	
	# then:
	asserts.is_equal(person.votes.size(), 3)
	asserts.is_equal(person.votes[0], "Bound")
	asserts.is_equal(person.votes[1], "Cría Cuervos")
	asserts.is_equal(person.votes[2], "Bad Luck Banging or Loony Porn")


func test_should_get_movies_as_string():
	# given:
	person.votes.append("Bound")
	person.votes.append("Cría Cuervos")
	person.votes.append("Bad Luck Banging or Loony Porn")
	
	# then:
	asserts.is_equal(person.votes_as_string_list, "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn")


func test_should_return_result_votes_as_string():
	# given:
	person.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	
	# then:
	asserts.is_equal(person.result_votes_to_string(), "John:\nBound\nCría Cuervos\nBad Luck Banging or Loony Porn")


func test_should_return_votes_as_string_with_penalty():
	# given:
	person.votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	person.penalty = 1
	
	# then:
	asserts.is_equal(person.result_votes_to_string(), "John (-1 pontos):\nBound\nCría Cuervos\nBad Luck Banging or Loony Porn")
