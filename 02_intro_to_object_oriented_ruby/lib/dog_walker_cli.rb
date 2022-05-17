def start_cli
  puts "Hi there! Welcome to the Dog Walker CLI!".cyan
end

# ✅ add 2 additional options for walking and feeding dogs
def print_menu_options
  puts "Here are the choices:"
  puts "  1. List all dogs"
  puts "  2. Add a dog"
  puts "Please choose the number matching your choice."
  puts 'At any time, type "exit" to leave the program'
end



# define a method `ask_for_choice` which prompts the user for input
# if the user types "exit" we'll print a message thanking them
# for using the CLI and invoke exit to terminate the program
# otherwise, return whatever the user typed in
def ask_for_choice
  input = gets.chomp
  if input == "exit"
    puts "Thanks for using the Dog Walker CLI!".green
    exit
  end
  input
end



# ✅ remove the print_dog method. We'll be using the Dog#print method instead

def print_dog(dog_hash)
  puts
  puts dog_hash[:name].green
  puts "  Age: #{dog_hash[:age]}"
  puts "  Breed: #{dog_hash[:breed]}"
  puts "  Image Url: #{dog_hash[:image_url]}"
  puts
end


# define a method `list_dogs` that will iterate over an array of
# dog hashes and call print_dog on each one.
def list_dogs(dogs)
  dogs.each do |dog_hash|
    print_dog(dog_hash)
  end
end


# ✅ Refactor
# define an `add_dog` method which accepts an array of dog
# instances as an argument. It should:
# ask the user for input of the
# dog's name, age, breed and image_url. 
# Take this information and use it to create a new instance
# of the dog class 
# add new instance to the dogs array passed as an argument
# print the newly added dog (by invoking dog.print)
def add_dog(dogs)
  print "What's the dog's name? "
  name = ask_for_choice
  print "What's the dog's age? "
  age = ask_for_choice
  print "What's the dog's breed? "
  breed = ask_for_choice
  print "What's the dog's image url? "
  image_url = ask_for_choice
  # ✅ Rework the code below to use the Dog class
  dog_hash = {
    name: name,
    age: age,
    breed: breed,
    image_url: image_url
  }
  dogs << dog_hash
  print_dog(dog_hash)
end


# ✅ Add two conditions for walking and feeding (3 or 4)

def handle_choice(choice)
  if choice == "1"
    list_dogs($dogs)
  elsif choice == "2"
    add_dog($dogs)
  elsif choice == "debug"
    binding.pry
  else
    puts "Whoops! I didn't understand that!".red
    puts "Please try again."
  end
end


# ✅ Add a helper method `choose_dog_from_collection` that will:
#  - accept an array of dog instances as an argument
#  - print a numbered list (starting from 1) of each dog's name (breed) 
#    using .each_with_index
# https://ruby-doc.org/core-2.7.4/Enumerable.html#method-i-each_with_index
#  - ask the user to choose a number matching the dog they want to interact with
#  - return the dog instance corresponding to the choice they made
#  - ask the user to choose again if their choice didn't match a dog

def choose_dog_from_collection(dogs)
  dogs.each_with_index do |dog, index|
    # ✅ print out a number using each dog's index and its name (breed)
  end
  puts "Type the number associated with the dog you'd like to choose"
  # this code converts the number typed by the user and stored as a string
  # to an integer and then subtracts 1 to get the corresponding index in
  # the dogs array
  index = ask_for_choice.to_i - 1
  # next we check if we got a valid choice and if not, we'll show an error 
  # and ask the user to choose again by invoking the method again.
  # we add index >= 0 to our condition because .to_i will return 0 if passed
  # a word that doesn't start with a number as an argument.
  # in that case, we'll end up with -1 and we'd prefer telling the user there
  # was a problem to doing dogs[-1] which actually returns the last dog in the array
  if index >= 0 && index < dogs.length
    dogs[index]
  else
    puts "Whoops! We couldn't find a dog matching your choice.".red
    puts "Please try again"
    choose_dog_from_collection(dogs)
  end
end

# ✅ Add a `walk_dog` method that will prompt the user to choose
# which dog to walk. After choosing a dog, invoke the `walk` method
# on the dog and then `print` it





# ✅ Add a `feed_dog` method that will prompt the user to choose
# which dog to feed. After choosing a dog, invoke the `feed` method
# on the dog and then `print` it