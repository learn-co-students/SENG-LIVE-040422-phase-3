class Dog 

  attr_accessor :name, :age, :breed, :favorite_treats, :last_walked_at, :last_fed_at
  # will generate these methods below
  # def name
  #   @name 
  # end

  # def name=(name)
  #   @name = name
  # end

  def initialize(name, age, breed, favorite_treats)
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
  end

  def walk
    @last_walked_at = Time.now
  end

  def feed
    @last_fed_at = Time.now
  end
  
  def print 
    puts ""
    puts @name.light_green
    puts "  age: #{@age}"
    puts "  breed: #{@breed}"
    puts "  favorite_treats: #{@favorite_treats}"
    puts "  last walked at: #{@last_walked_at}"
    puts "  last fed at: #{@last_fed_at}"
    puts ""
  end


end