require 'test_helper'

class TestTrie < MiniTest::Test
  def test_trie
    trie = Trie.new('test')
    trie.add_node(1, 'test string1')
    trie.add_node('ab', 'test string2')
    trie.add_node('bc', 'test string3')
    trie.add_node('bc', 'test string4')
    assert_equal trie.search(1), ['test string1']
    assert_equal trie.search('ab'), ['test string2']
    assert_equal trie.search('bc'), ['test string3', 'test string4']
  end

  def test_node
    node = Node.new
    node << 'this is a test'
    assert_equal node.values, ['this is a test']
  end
end
