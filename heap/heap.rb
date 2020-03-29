class Heap
  def initialize()
    @container = Array.new(1)
    @size = 1
    @last_index = -1
  end

  # Bubbles up from index to a valid position in the heap.
  def heapify(index)
    curr_index = index

    while parent(curr_index) >= 0 && @container[parent(curr_index)] > @container[curr_index]
      # swap parent and curr_index
      tmp = @container[parent(curr_index)]
      @container[parent(curr_index)] = @container[curr_index]
      @container[curr_index] = tmp

      curr_index = parent(curr_index)
    end

    return
  end
  
  # Inserts val into a valid position in the heap.
  def insert(val)
    @last_index += 1
    
    # check if we already have allocated space for this index
    if @size >= @last_index
      @container[@last_index] = val
    else
      @size += 1
      @container << val
    end
    
    heapify(@last_index)
  end

  # Removes and returns the top element of the Heap.
  # Replaces the top element with the element in the last_index of the heap.
  # Bubbles down until it restores the min-heap property.
  def pop_min()
    return nil if @last_index < 0

    min = @container.first

    # place item at last index at the top of the heap
    @container[0] = @container[@last_index]
    @last_index -= 1

    curr_index = 0
    left_child_index = left_child(curr_index)
    right_child_index = right_child(curr_index)
  
    while left_child_index <= @last_index || right_child_index <= @last_index do
      # if curr node < both children, we're done
      return min if @container[curr_index] <= [@container[left_child_index], @container[right_child_index]].min

      tmp = @container[curr_index]

      # choose smaller of the children
      if @container[left_child_index] <= @container[right_child_index]
        @container[curr_index] = @container[left_child_index]
        @container[left_child_index] = tmp

        curr_index = left_child_index
      else
        @container[curr_index] = @container[right_child_index]
        @container[right_child_index] = tmp

        curr_index = right_child_index
      end

      left_child_index = left_child(curr_index)
      right_child_index = right_child(curr_index)
    end

    # consider left child swap if left child exists
    if left_child_index <= @last_index
      if @container[curr_index] <= @container[left_child_index]
        tmp = @contianer[curr_index]
        @container[curr_index] = @container[left_child_index]
        @container[left_child_index] = tmp
      end
    end

    return min
  end

  def top()
    return @container.first
  end

  # Equation: floor((i-1)/2)
  def parent(index)
    return (index-1)/2
  end

  # Equation: 2*i + 1
  def left_child(index)
    return 2*index + 1
  end

  # Equation: 2*i + 2
  def right_child(index)
    return 2*index + 2
  end

  def print_heap()
    return if @last_index < 0

    level = [0]
    while !level.empty?
      str = ""
      len = level.length
      (0...len).each do |i|
        index = level.shift
        level << left_child(index) if left_child(index) <= @last_index
        level << right_child(index) if right_child(index) <= @last_index

        str += @container[index].to_s + " "
      end

      puts str
    end
  end
end


# Some test cases
h = Heap.new()
h.insert(10)
h.insert(5)
h.insert(15)
h.insert(7)
h.insert(20)
h.insert(19)
h.insert(1)
h.insert(0)
h.insert(-10)
h.insert(100)
h.print_heap()

puts("min is #{h.pop_min()}")
h.print_heap()

h.insert(-100)
h.print_heap()

h.insert(-1)
h.print_heap()