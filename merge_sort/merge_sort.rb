arr = [98, 12, 76, 23, 8, 58, 37, 42, 69, 420, 32, 72, 12, 63, 90, 902, 25, 77]

def merge_sort(a)
  if a.length <= 1
    return a
  end
  mid = a.length / 2
  left_arr = a[0...mid]
  right_arr = a[mid..-1]

  sorted_left = merge_sort(left_arr)
  sorted_right = merge_sort(right_arr)

  sort(sorted_left, sorted_right)
end


def sort(a,b)
  sorted_array = []
  while !a.empty? && !b.empty?
    if a.first <= b.first
      sorted_array << a.shift
    else
      sorted_array << b.shift
    end
  end
  return sorted_array.concat(a).concat(b)
end

sorted_arr = merge_sort(arr)

puts "unsorted: #{arr.inspect}"
puts "sorted: #{sorted_arr.inspect}"
