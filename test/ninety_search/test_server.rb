require 'test_helper'

class TestServer < MiniTest::Test

  def bob
    {
      'name' => 'bob',
      'id' => '1',
      'hobbies' => ['swiming', 'jog', 'code']
    }
  end

  def john
    {
      'name' => 'john',
      'id' => '2',
      'hobbies' => ['boxing', 'code']
    }
  end

  def test_worker
    worker = Server::Worker.new
    worker.setup_tries([bob, john])
    assert_equal worker.search('name', 'john'), [john]
    assert_equal worker.search('id', '1'), [bob]
    assert_equal worker.search('hobbies', 'code'), [bob, john]
    assert_equal worker.search('hobbies', 'movie'), []
  end

  def test_engine
    engine = Server::Engine.new
    engine.load_data('users', [bob, john])
    assert_equal engine.search('users', 'name', 'john'), [john]
    refute engine.search('users1', 'name', 'john')
  end
end
