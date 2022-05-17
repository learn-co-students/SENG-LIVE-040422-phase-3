class Dog

  # ✅✅ we want to be able to access a dog's last_fed_at and last_walked at times

  # ✅✅ we also want to be able to access the dog's favorite_treats
 
  # attr_accessor gives me both the attr_reader & attr_writer
  attr_accessor :name, :age, :breed, :image_url, :last_walked_at, :last_fed_at, :favorite_treats

  # # attr_reader
  # def name
  #   @name
  # end

  # # attr_writer
  # def name=(name)
  #   @name = name
  # end

  # ✅✅ we should be able to create dogs with a name, age, breed, and image_url
  def initialize(name, age, breed, image_url)
    @name = name
    @age = age
    @breed = breed
    @image_url = image_url
  end

  

  # ✅ we want to be able to take a dog on a walk and track when they were last walked
  def walk
    @last_walked_at = Time.now
  end

  # ✅ we want to be able to feed a dog and track when they were last fed
  def feed
    @last_fed_at = Time.now
  end

  # ✅ we want to be able to check if a dog needs a walk (hasn't been walked in the last 4 hours)
  def needs_a_walk?
    if last_walked_at
      !last_walked_at.between?(10.seconds.ago, Time.now)
    else
      true
    end
  end

  # ✅ we want to be able to check if a dog is hungry (hasn't been fed in the last 6 hours)
  def hungry?
    if last_fed_at
      !last_fed_at.between?(15.seconds.ago, Time.now)
    else
      true
    end
  end

  # ✅ we want to be able to print details about a dog (this time including the last walked at and last fed at times)
  def print
    puts
    puts self.name.green
    puts "  Age: #{self.age}"
    puts "  Breed: #{self.breed}"
    puts "  Image Url: #{self.image_url}"
    puts "  Last walked at: #{self.last_walked_at}"
    puts "  Last fed at: #{self.last_fed_at}"
    puts
  end
  # def print_dog(dog_hash)
  #   puts
  #   puts dog_hash[:name].green
  #   puts "  Age: #{dog_hash[:age]}"
  #   puts "  Breed: #{dog_hash[:breed]}"
  #   puts "  Image Url: #{dog_hash[:image_url]}"
  #   puts
  # end
end