extends WATTest

var person: SCPerson

func pre():
	person = SCPerson.new("John")


func test_should_initialize():
	asserts.is_equal(person.name, "John")
	asserts.is_equal(person.penalty, 0)
	asserts.is_not_null(person.votes)
	asserts.is_empty(person.votes)


func test_should_return_votes_as_string():
	# given:
	person.votes = [
		"Bound",
		"Cría Cuervos",
		"Bad Luck Banging or Loony Porn"
	]
	
	# then:
	asserts.is_equal(person.votes_to_string(), "*John:*\n1. Bound\n2. Cría Cuervos\n3. Bad Luck Banging or Loony Porn")


func test_should_move_vote_up():
	# given:
	person.votes = [
		"Bound",
		"Cría Cuervos",
		"Bad Luck Banging or Loony Porn"
	]
	
	# then:
	person.move_vote_up(2)
	asserts.is_equal(person.votes, ["Bound", "Bad Luck Banging or Loony Porn", "Cría Cuervos"])
	person.move_vote_up(1)
	asserts.is_equal(person.votes, ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"])


func test_should_not_move_vote_up_if_index_is_invalid():
	# given:
	person.votes = [
		"Bound",
		"Cría Cuervos",
		"Bad Luck Banging or Loony Porn"
	]
	person.move_vote_up(0)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	person.move_vote_up(3)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	person.move_vote_up(-1)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])


func test_should_move_vote_down():
	# given:
	person.votes = [
		"Bound",
		"Cría Cuervos",
		"Bad Luck Banging or Loony Porn"
	]
	
	# then:
	person.move_vote_down(0)
	asserts.is_equal(person.votes, ["Cría Cuervos", "Bound", "Bad Luck Banging or Loony Porn"])
	person.move_vote_down(1)
	asserts.is_equal(person.votes, ["Cría Cuervos", "Bad Luck Banging or Loony Porn", "Bound"])


func test_should_not_move_vote_down_if_index_is_invalid():
	# given:
	person.votes = [
		"Bound",
		"Cría Cuervos",
		"Bad Luck Banging or Loony Porn"
	]
	person.move_vote_down(-1)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	person.move_vote_down(2)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	person.move_vote_down(3)
	asserts.is_equal(person.votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])









