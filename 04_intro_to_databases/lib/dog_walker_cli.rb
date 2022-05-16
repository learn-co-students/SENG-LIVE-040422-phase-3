Dog.create(name: "Lennon",age: "1 year",breed: "Pomeranian",favorite_treats: "cheese")

def start_cli
  puts "hello! Welcome to the Dog Walker CLI"
  print_menu_options
  choice = ask_for_choice
  until choice == "exit"
    handle_user_choice(choice)
    choice = ask_for_choice
  end
  puts "Thank you for using the Dog Walker CLI!"
end

def print_menu_options
  puts "Here's a list of the options. Type:".cyan
  puts "  1. To add a dog".cyan
  puts "  2. To list dogs".cyan
  puts "  3. To feed a dog".cyan
  puts "  4. To walk a dog".cyan
  puts "  5. To view a list of dogs who need feeding".cyan
  puts "  6. To view a list of dogs who need walking".cyan
  puts "  menu to show the options again, or".cyan
  puts "  exit to leave the program".cyan
end

def ask_for_choice
  print "What would you like to do? "
  gets.chomp
end

def handle_user_choice(choice)
  if choice == "1"
    add_dog
  elsif choice == "2"
    list_dogs
  elsif choice == "3"
    feed_dog
  elsif choice == "4"
    walk_dog
  elsif choice == "5"
    list_dogs_to_feed
  elsif choice == "6"
    list_dogs_to_walk
  elsif choice == "menu"
    print_menu_options
  elsif choice == "debug" 
    binding.pry
  else 
    puts "Whoops! I didn't understand your choice".red
  end
  print_menu_options
end

def add_dog
  puts "Sure! Let's add your dog!"
  print "What's your dog's name? "
  name = gets.chomp
  print "What's your dog's age? "
  age = gets.chomp
  print "What's your dog's breed? "
  breed = gets.chomp
  print "What are your dog's favorite treats? "
  favorite_treats = gets.chomp
  # make a new instance of dog with the user's answers
  dog = Dog.create(
    name: name,
    age: age,
    breed: breed,
    favorite_treats: favorite_treats
  )
  dog.print
end

def list_dogs
  puts "here are the dogs"
  Dog.all.each do |dog|
    dog.print
  end
end

def feed_dog
  # List dogs with a number up front and ask a user to choose the number corresponding
  # to the dog they want to feed
  puts "Which dog would you like to feed? (type in their number)"
  Dog.all.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name} (#{dog.breed})"
  end
  dog_index = gets.chomp.to_i - 1
  until dog_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    dog_index = gets.chomp.to_i - 1
  end
  dog = Dog.all[dog_index]
  dog.feed
  dog.print
end

def walk_dog
  puts "Which dog would you like to walk? (type in their number)"
  Dog.all.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name} (#{dog.breed})"
  end
  dog_index = gets.chomp.to_i - 1
  until dog_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    dog_index = gets.chomp.to_i - 1
  end
  dog = Dog.all[dog_index]
  dog.walk
  dog.print
end

def list_dogs_to_feed
  puts "Here are all of the hungry dogs:"
  if Dog.needs_feeding.any?
    Dog.needs_feeding.each do |dog|
      puts "#{dog.name} (#{dog.breed})"
    end
  else
    puts "Looks like everyone is satisfied!".light_green
  end
end

def list_dogs_to_walk
  puts "Here are all of the restless dogs:"
  if Dog.needs_walking.any?
    Dog.needs_walking.each do |dog|
      puts "#{dog.name} (#{dog.breed})"
    end
  else
    puts "Looks like everyone is content!".light_green
  end
end