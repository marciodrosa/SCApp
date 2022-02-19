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


func test_should_convert_to_dictionary():
	# given:
	data.curator_index = 2
	data.movies_as_string_list = "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn"
	data.people[0].votes = ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"]
	data.people[1].votes = ["Cría Cuervos", "Bound", "Bad Luck Banging or Loony Porn"]
	data.people[2].votes = ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"]
	data.people[3].votes = ["Bound", "Bad Luck Banging or Loony Porn", "Cría Cuervos"]
	data.people[3].penalty = 3
	
	# when:
	var dict = data.to_dictionary()
	
	# then:
	asserts.is_equal(dict["curator_index"], 2)
	asserts.is_equal(dict["movies_as_string_list"], "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn")
	asserts.is_equal(dict["people"].size(), 4)
	asserts.is_equal(dict["people"][0]["name"], "Felipe")
	asserts.is_equal(dict["people"][0]["penalty"], 0)
	asserts.is_equal(dict["people"][0]["votes"], ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	asserts.is_equal(dict["people"][1]["name"], "Júlia")
	asserts.is_equal(dict["people"][1]["penalty"], 0)
	asserts.is_equal(dict["people"][1]["votes"], ["Cría Cuervos", "Bound", "Bad Luck Banging or Loony Porn"])
	asserts.is_equal(dict["people"][2]["name"], "Márcio")
	asserts.is_equal(dict["people"][2]["penalty"], 0)
	asserts.is_equal(dict["people"][2]["votes"], ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"])
	asserts.is_equal(dict["people"][3]["name"], "Rafa")
	asserts.is_equal(dict["people"][3]["penalty"], 3)
	asserts.is_equal(dict["people"][3]["votes"], ["Bound", "Bad Luck Banging or Loony Porn", "Cría Cuervos"])


func test_should_convert_from_dictionary():
	# given:
	var dict = {
		"curator_index": 2,
		"movies_as_string_list": "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn",
		"people": [
			{ "name": "Felipe", "penalty": 0, "votes": ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"] },
			{ "name": "Júlia", "penalty": 0, "votes": ["Cría Cuervos", "Bound", "Bad Luck Banging or Loony Porn"] },
			{ "name": "Márcio", "penalty": 0, "votes": ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"] },
			{ "name": "Rafa", "penalty": 3, "votes": ["Bound", "Bad Luck Banging or Loony Porn", "Cría Cuervos"] },
		]
	}
	
	# when:
	data.from_dictionary(dict)
	
	# then:
	asserts.is_equal(data.curator_index, 2)
	asserts.is_equal(data.movies_as_string_list, "Bound\nCría Cuervos\nBad Luck Banging or Loony Porn")
	asserts.is_equal(data.people.size(), 4)
	asserts.is_equal(data.people[0].name, "Felipe")
	asserts.is_equal(data.people[0].penalty, 0)
	asserts.is_equal(data.people[0].votes, ["Bound", "Cría Cuervos", "Bad Luck Banging or Loony Porn"])
	asserts.is_equal(data.people[1].name, "Júlia")
	asserts.is_equal(data.people[1].penalty, 0)
	asserts.is_equal(data.people[1].votes, ["Cría Cuervos", "Bound", "Bad Luck Banging or Loony Porn"])
	asserts.is_equal(data.people[2].name, "Márcio")
	asserts.is_equal(data.people[2].penalty, 0)
	asserts.is_equal(data.people[2].votes, ["Bad Luck Banging or Loony Porn", "Bound", "Cría Cuervos"])
	asserts.is_equal(data.people[3].name, "Rafa")
	asserts.is_equal(data.people[3].penalty, 3)
	asserts.is_equal(data.people[3].votes, ["Bound", "Bad Luck Banging or Loony Porn", "Cría Cuervos"])
