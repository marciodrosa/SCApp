extends WATTest

var data: SCData

func pre():
	data = SCData.new()


func test_should_initialize():
	asserts.is_equal(data.people.size(), 4)
	asserts.is_equal(data.people[0].name, "Felipe")
	asserts.is_equal(data.people[1].name, "Júlia")
	asserts.is_equal(data.people[2].name, "Márcio")
	asserts.is_equal(data.people[3].name, "Rafa")
	asserts.is_equal(data.curator_index, -1)
	asserts.is_not_null(data.movies)
	asserts.is_empty(data.movies)

func test_should_set_movies_as_string():
	# given:
	data.movies_as_string_list = "Bound\nCría Cuervos\n\nBad Luck Banging or Loony Porn"
	
	# then:
	asserts.is_equal(data.movies.size(), 3)
	asserts.is_equal(data.movies[0], "Bound")
	asserts.is_equal(data.movies[1], "Cría Cuervos")
	asserts.is_equal(data.movies[2], "Bad Luck Banging or Loony Porn")


func test_should_get_movies_as_string():
	# given:
	data.movies.append("Bound")
	data.movies.append("Cría Cuervos")
	data.movies.append("Bad Luck Banging or Loony Porn")
	
	# then:
	asserts.is_equal(data.movies_as_string_list, "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn")


func test_should_return_voters_array():
	# given:
	data.curator_index = 2
	
	# when:
	var result = data.voters
	
	# then:
	asserts.is_equal(result.size(), 3)
	asserts.is_equal(result[0].name, "Felipe")
	asserts.is_equal(result[1].name, "Júlia")
	asserts.is_equal(result[2].name, "Rafa")
