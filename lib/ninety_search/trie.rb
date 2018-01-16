# frozen_string_literal: true

class Trie
  def initialize(name)
    @name = name
    @root = Node.new
  end

  def add_node(str, obj)
    str = String(str)
    return if str == ''
    root = @root
    str.each_char do |c|
      root.nodes[c] = Node.new unless root.nodes[c]
      root = root.nodes[c]
    end
    root << obj
  end

  def search(str)
    str = String(str)
    return if str == ''
    root = @root
    str.each_char do |c|
      break unless root.nodes[c]
      root = root.nodes[c]
    end
    root.values
  end

end

class Node
  attr_accessor :nodes
  attr_reader :values

  def initialize
    @nodes = {}
    @values = []
  end

  def add_value(value)
    @values << value
  end

  alias_method :<<, :add_value
end
