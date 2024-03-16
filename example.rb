#this is a new practice file

class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    puts "#{@name} lets out a spooky growl"
  end

  def name
    @name
  end

  def name=(n)
    @name = n
  end
end

milo = GoodDog.new("Milo")
puts milo.speak
prince = GoodDog.new("Prince")
puts prince.speak

puts milo.get_name
puts prince.get_name

prince.set_name("Koa")

puts prince.get_name
