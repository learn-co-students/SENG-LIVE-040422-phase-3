class Dog 

  @@all = nil

  def self.all
    if @@all 
      @@all
    else
      rows = DB.execute("SELECT * FROM dogs")
      @@all = rows.map do |row|
        self.new_from_row(row)
      end
    end
  end

  def self.new_from_row(row)
    self.new(row.transform_keys(&:to_sym))
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
  attr_reader :id
  def initialize(id: nil, name:, age:, breed:, favorite_treats:, last_walked_at: nil, last_fed_at: nil)
    @id = id
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
    @last_walked_at = last_walked_at
    @last_fed_at = last_fed_at
  end

  def save
    if id 
      query = <<-SQL
        UPDATE dogs
        SET name = ?,
            age = ?,
            breed = ?,
            favorite_treats = ?,
            last_walked_at = ?,
            last_fed_at = ?
        WHERE
            id = ? 
      SQL
      DB.execute(
        query,
        self.name,
        self.age,
        self.breed,
        self.favorite_treats,
        self.last_walked_at && self.last_walked_at.strftime('%Y-%m-%d %H:%M:%S'),
        self.last_fed_at && self.last_fed_at.strftime('%Y-%m-%d %H:%M:%S'),
        self.id
      )
    else
      query = <<-SQL
        INSERT INTO dogs 
        (name, age, breed, favorite_treats, last_walked_at, last_fed_at)
        VALUES
        (?, ?, ?, ?, ?, ?)
      SQL
      DB.execute(
        query,
        self.name,
        self.age,
        self.breed,
        self.favorite_treats,
        self.last_walked_at,
        self.last_fed_at
      )
      @id = DB.execute("SELECT last_insert_rowid()")[0]["last_insert_rowid()"]
      Dog.all << self
    end
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