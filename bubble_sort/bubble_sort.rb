# Bubble sort method

def bubb_sort(arr) 
    n = array.length
  loop do
    swapped = false

    (n-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i] # Swap elements
        swapped = true
      end
    end

    break unless swapped
  end

  array
end


sort_this = [3,7,2,1,6,8,0,9,2,5,7,3,1,9]
bubb_sort(sort_this)
