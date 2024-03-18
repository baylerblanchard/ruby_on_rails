#this is a new practice file

class MyCar
  attr_accessor :make, :year, :color, :speed

  def initialize(m, y, c)
    @make = m
    @year = y
    @color = c

    @speed = 0

  end

  def info
    puts "#{self.make} #{self.year} #{self.color}"
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

  def change_speed(n)
    @speed += n
    puts "speed increases to  #{self.speed}"
  end
end

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
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
end

milo = GoodDog.new("Milo", "32cm", "10lbs")
milo.speak
prince = GoodDog.new("Prince", "67cm", "55lbs")
prince.speak

puts milo.name
puts prince.name

prince.set_name("Koa")

puts prince.name

milo.info

bayler_car = MyCar.new("toyota", "1999", "red")
bayler_car.info
bayler_car.car_state("off")
bayler_car.change_speed(55)
bayler_car.change_speed(45)
