#methods for the caeser cipher

def caeser_cipher(string1, num)
    word1 = string1.split('')
    word1.map! do |letter|
        if letter =~ /[a-zA-Z]/
            let_num = letter.ord
            let_num += num

            if letter >= 'a' && letter <= 'z'
                let_num -= 26 if let_num > 'z'.ord
            elsif letter >= 'A' && letter <= 'Z'
                let_num -= 26 if let_num > 'Z'.ord
            end

            letter = let_num.chr
        end
        letter
    end

    string1 = word1.join
    puts string1
end

caeser_cipher('Hello, my name is Bayler',22)