arr = [98,12,76,23]

def merge_sort(arr)
  if arr.length <= 1
    return arr
  end
  mid = arr.length / 2
  left_arr = arr[0..mid-1]
  right_arr = arr[mid..arr.length]

  p left_arr
  p right_arr
end

merge_sort(arr)