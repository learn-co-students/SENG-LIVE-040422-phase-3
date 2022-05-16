lennon = Dog.create(name: "Lennon", age: "1 year", breed: "Pomeranian", favorite_treats: "cheese")
memphis = Dog.create(name: "Memphis", age: "2 years", breed: "German Shorthaired Pointer", favorite_treats: "bacon")

# create a couple of walks and feedings for Lennon 
lennon.walks.create(time: 4.hours.ago)
lennon.walks.create(time: 6.hours.ago)

lennon.feedings.create(time: 4.hours.ago)

# create a couple of walks and feedings for Memphis
memphis.walks.create(time: 3.hours.ago)
memphis.feedings.create(time: 1.hour.ago)