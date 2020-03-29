# LRU Cache description: https://leetcode.com/problems/lru-cache/ 
# Implementation overview: use a doubly linked list to keep priority and a hashtable to get instant access to nodes.

class Node
  attr_accessor :key, :val, :prev, :next

  def initialize(key, val)
    @key = key
    @val = val
    @prev = nil
    @next = nil
  end
end

class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @nodes = {}

    @front = Node.new(nil, nil)
    @back = Node.new(nil, nil)

    @front.next = @back
    @back.prev = @front
  end

  def insert_at_front(node)
    node.next = @front.next
    @front.next.prev = node
    @front.next = node
    node.prev = @front

    return
  end

  def remove_node_from_list(node)
     # connect node's current prev and current next
    original_prev = node.prev
    original_prev.next = node.next
    node.next.prev = original_prev

    return
  end

  def put(key, value)
    node = nil

    # if node already exists, remove it
    if !@nodes[key].nil?
      node = @nodes[key]
      node.val = value
      remove_node_from_list(node)
    else
      pop() if @nodes.length >= @capacity
      node = Node.new(key, value)
      @nodes[key] = node
    end

    insert_at_front(node)
  end

  def pop()
    # no nodes to pop
    return if @front.next == @back

    popped = @back.prev
    popped.prev.next = @back
    @back.prev = popped.prev

    @nodes.delete(popped.key)
    
    return
  end

  def get(key)
    node = @nodes[key]

    return -1 if node.nil?

    remove_node_from_list(node)
    insert_at_front(node)

    return node.val
  end
end
