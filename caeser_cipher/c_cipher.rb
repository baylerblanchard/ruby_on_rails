#methods for the caeser cipher

def caeser_cipher(string1, num)
        word1 = string1.split('')
        word1.each {|letter|
            let_num = letter.ord
            let_num += num

            if let_num > 122
                let_num -= 26
            end
            
            puts (letter.ord)
            
            puts (let_num.chr)
        }
        
        
        puts(word1)
end


caeser_cipher('bayler',15)
