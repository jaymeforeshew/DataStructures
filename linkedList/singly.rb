# Node class, to be elements of a linked list
class Node
  attr_reader :val, :next
  attr_writer :next

  def initialize(val)
    @val = val
    @next = nil
  end
end

# LinkedList class which containing ptr to head and length
class LinkedList
  attr_reader :length

  def initialize(node)
    @length = 1
    @head = node
  end

  def exists?(val)
    tmp = @head
    until tmp.nil?
      return true if tmp.val == val

      tmp = tmp.next
    end

    return false
  end

  def insert(node)
    tmp = @head
    tmp = tmp.next until tmp.next.nil?

    tmp.next = node
    @length += 1
  end

  def remove(val)
    if @head.val == val
      @head = @head.next
      return
    end

    tmp = @head
    while !tmp.nil? && !tmp.next.nil?
      if tmp.next.val != val
        tmp = tmp.next
        next
      end

      tmp.next = tmp.next.next
      @length -= 1
      return
    end
  end

  def print
    list = ""
    tmp = @head
    until tmp.next.nil?
      list += "#{tmp.val}->"
      tmp = tmp.next
    end

    list += tmp.val.to_s
    puts list
  end
end
