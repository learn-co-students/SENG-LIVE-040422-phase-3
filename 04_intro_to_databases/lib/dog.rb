class Dog 

  @@all = []

  def self.all
    @@all
  end

  def self.create(attributes) 
    self.new(attributes).save
  end

  def self.needs_feeding
    self.all.filter do |dog|
      dog.needs_a_meal?
    end
  end

  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end

  attr_accessor :name, :age, :breed, :favorite_treats, :last_walked_at, :last_fed_at
  # will generate these methods below
  # def name
  #   @name 
  # end

  # def name=(name)
  #   @name = name
  # end

  def initialize(name:, age:, breed:, favorite_treats:)
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
  end

  def save
    Dog.all << self
    self
  end

  def walk
    self.last_walked_at = Time.now
  end

  def needs_a_walk?
    if !last_walked_at
      true
    else
      last_walked_at < 10.seconds.ago
    end
  end

  def feed
    self.last_fed_at = Time.now
  end

  def needs_a_meal?
    if !last_fed_at
      true
    else
      last_fed_at < 6.seconds.ago
    end
  end
  
  def print 
    puts ""
    puts name.light_green
    puts "  age: #{age}"
    puts "  breed: #{breed}"
    puts "  favorite_treats: #{favorite_treats}"
    puts "  last walked at: #{last_walked_at}"
    puts "  last fed at: #{last_fed_at}"
    puts ""
  end


end