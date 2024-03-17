#this is a new practice file

class MyCar
  attr_accessor :make, :year, color

  def initialize(m, y, c)
    @make = m
    @year = y
    @color = c

    speed = 0

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
