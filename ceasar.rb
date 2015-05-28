#
def ceasar_cipher(string, shift_factor)
  alphabet = ('a'..'z').to_a
  string.downcase!
  word =""
  string.split("").each do |letter|
    #p letter
    word += ceasar_letter(letter, shift_factor)
  end
  word
end

def ceasar_letter(letter, shift_factor)
  p letter
  alphabet = ('a'..'z').to_a
  if not alphabet.include?(letter)
    return letter
  end
  letter_index = alphabet.index(letter)
  if (letter_index + shift_factor) > alphabet.length
    letter = alphabet[letter_index + shift_factor - alphabet.length]
  elsif alphabet.include?(letter)
    letter = alphabet[letter_index + shift_factor]
  end
end

#----------------------------------------------------------------------------------------------------------------------

def stock_picker(stock_prices)
  result = []
  result_price = 0 
  current_date = 0 
  stock_prices1 = stock_prices
  stock_prices.each do |price|
    stock_prices1.slice!(0)
    end_date, price_difference = find_highest(price, stock_prices1)
    puts "resultprice: #{result_price}, price_difference #{price_difference}"
    if result_price < price_difference
      print "ok"
      result_price = price_difference

      result = [current_date, stock_prices.find_index(price_difference)]
    end
    current_date += 1
  end
  result
end


def find_highest(price, stock_prices)
  p stock_prices
  price_difference = stock_prices.max - price
  end_date = stock_prices.find_index(stock_prices.max)
  return end_date, price_difference
end

#p find_highest(5, [1, 20 , 50 , 25, 150])
p stock_picker([17,3,6,9,15,8,6,1,10])