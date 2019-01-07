require './singly'

## Testing this out...
head = Node.new(0)
linked_list = LinkedList.new(head)

(1..10).each do |val|
  node = Node.new(val)
  linked_list.insert(node)
end

linked_list.print
puts "Exists(1) should return true: #{linked_list.exists?(1)}"
puts "Length should return 11: #{linked_list.length}"
puts 'Remove(4)'
linked_list.remove(4)
puts "Exists 4 should return false: #{linked_list.exists?(4)}"
puts "Length should now be 10: #{linked_list.length}"
linked_list.print