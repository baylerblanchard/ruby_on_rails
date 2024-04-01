# this is a new practice file

class MyCar
  attr_accessor :make, :color, :speed
  attr_reader :year

  def initialize(m, y, c)
    @make = m
    @year = y
    @color = c

    @speed = 0

  end

  def info
    puts "#{self.make} #{self.year} #{self.color}"
  end

  def spray_paint(c)
    @color = c
    puts "new color is #{self.color}"
  end

  def car_state(ans)
    if ans == "off"
        puts "car is off"
    end
    if ans == "brake"
        puts "car is braking"
    end
    if ans == "go"
        puts "car is in go mode"
    end
  end

  def user_error
    puts "the car is in park and cannot be driven"
  end

  def display_year
    puts "this car was made in #{self.year}"
  end

  def miles_per_gallon(miles, gallons)
    puts "This vehicle is at #{miles / gallons} miles per gallon"

  end

  def change_speed(n)
    @speed += n
    puts "speed increases to  #{self.speed}"
  end

  def to_s
    "this vehicle is a #{make} from #{year} and is the color #{color}"
  end
end

class Bayler
  attr_accessor :mood, :status, :to_do_list

  def mood_analyze
    if mood == "stressed"
      status = "needs to relax"
      puts status
    end

    if mood == "happy"
      status = "enjoying the day"
      puts status
    end

    if mood == "depressed"
      status = "enjoy some bud"
      puts status
    end
  end
end

class Cinema
  attr_accessor :name, :location

end

class Movie
  attr_accessor :name

end

class GoodDog
  @@num_of_dogs = 0
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @@num_of_dogs += 1
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def speak
    puts "#{self.name} lets out a spooky growl"
  end

  def info
    puts "#{self.name} is #{self.height} tall and weights #{self.weight}"
  end

  def self.total_dogs
    @@num_of_dogs
  end

end

milo = GoodDog.new("Milo", "32cm", "10lbs")
milo.speak
prince = GoodDog.new("Prince", "67cm", "55lbs")
prince.speak

puts milo.name
puts prince.name

prince.name = "Koa"

puts prince.name

milo.info

bayler_car = MyCar.new("toyota", "1999", "red")
bayler_car.info
bayler_car.car_state("off")
bayler_car.change_speed(55)
bayler_car.change_speed(45)
bayler_car.spray_paint("black")
puts GoodDog.total_dogs
bayler_car.miles_per_gallon(45, 6)
puts bayler_car
bayler =Bayler.new()
bayler.mood = "stressed"
bayler.mood_analyze
