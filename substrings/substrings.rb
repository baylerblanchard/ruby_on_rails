#this is my substring project

def substring (words, word_list)
    match = Hash.new(0)
    words = words.downcase
    word_list.each do |word|
        match[word] += words.scan(word).length if words.include?(word)
    end
    match
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  
p substring("Howdy partner, sit down! How's it going?", dictionary)