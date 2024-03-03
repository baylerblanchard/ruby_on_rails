#methods for the caeser cipher

def caeser_cipher(string1, num)
    word1 = string1.split('')
    word1.each {|letter|
      letter = letter.ord
      puts (letter)
    }
    
    
    puts(word1)
end


caeser_cipher('bayler',15)

bayler = 'A'

puts(bayler.ord)