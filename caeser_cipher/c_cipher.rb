#methods for the caeser cipher

def caeser_cipher(string1, num)
    word1 = string1.split('')
    word1.each {|letter|
      let_num = letter.ord
      let_num += num
      
      puts (letter.ord)
      
      puts (let_num)
    }
    
    
    puts(word1)
end


caeser_cipher('bayler',15)
