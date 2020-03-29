class TrieNode
  attr_accessor :char, :next

  def initialize(char)
    @char = char
    @next = {}
    @is_word = false
  end

  def set_word()
    @is_word = true
  end

  def is_word()
    return @is_word
  end
end

class Trie
  def initialize()
    @front = TrieNode.new('')
  end

  def add_word(word)
    curr_node = @front
    
    (0...word.length).each do |i|
      char = word[i]
      if curr_node.next[char].nil?
        curr_node.next[char] = TrieNode.new(char)
      end

      curr_node = curr_node.next[char]
    end

    curr_node.set_word()
  end

  def is_word(word)
    curr_node = @front
    (0...word.length).each do |i|
      char = word[i]

      return false if curr_node.next[char].nil?
      curr_node = curr_node.next[char]
    end

    return curr_node.is_word()
  end
end


# some test cases
t = Trie.new()

t.add_word('spaghetti')
puts(t.is_word('spaghetti'))
puts(t.is_word('spaghett'))

t.add_word('spaghett')
puts(t.is_word('spaghetti'))
puts(t.is_word('spaghett'))

t.add_word('spaghetti')
puts(t.is_word('spaghetti'))
puts(t.is_word('spaghettio'))