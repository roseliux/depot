# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(n)
  # write your code in Ruby 2.2
  # puts n
  binary =  n.to_s(2)
  count = 0
  temp = 0
  
  for i in 0..(binary.size)
    if binary[i] == "0" and binary[i..-1].end_with?("1")
      count += 1
    else
      temp = count if count > temp
      count = 0
    end
  end
  temp
end