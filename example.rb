#this is a new practice file

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    puts "#{name} lets out a spooky growl"
  end

  def info
    puts "#{name} is #{height} tall and weights #{weight}"
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
