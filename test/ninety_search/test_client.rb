require 'test_helper'

class TestClient < MiniTest::Test

  def bob
    {
      'name' => 'bob',
      'id' => '1',
      'hobbies' => ['swiming', 'jog', 'code']
    }
  end

  def test_search_without_drb
    refute Client.search('data/users.json', 'name', 'bob')
  end

  def test_search
    Client.stub :server, Server::Engine.new do
      Client.load_data('data/users.json', [bob])
      assert_equal Client.search('data/users.json', 'name', 'bob'), [bob]
    end
  end
end
