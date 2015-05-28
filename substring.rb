def substrings(string, dictionary)
  string = string.split(" ")
  wordcount = []
  string.each do |word|
    wordcount += wordScan(word.downcase, dictionary)
  end
  countWords(wordcount)
end

def wordScan(word, dictionary)
  word = word.split("")
  output = []

  dictionary = dictionary.map do |dict_word|
    dict_word = dict_word.split("")
  end
  dictionary.each do |dict_word|
    #p dict_word.join
    if dict_word == dict_word & word
      output << dict_word.join
    end
  end
  output
end

def countWords(words)
  countedWords = Hash.new
  words.each do |word|
    if countedWords[word]
      countedWords[word] += 1
    else
      countedWords[word] = 1
    end
  end
  countedWords
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

string = "Howdy partner, sit down! How's it going?"
string2 = "below"

p substrings(string, dictionary)