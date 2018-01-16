require 'test_helper'

class TestLauncher < MiniTest::Test
  def launcher
    Launcher.new
  end

  def bob
    { 'name' => 'bob', 'id' => 1, 'hobbies' => ['swim', 'movie'] }
  end

  def filename
    File.expand_path '../../data/users.json', __FILE__
  end

  def test_load_file
    assert_equal launcher.load_file(filename), [bob]
  end

  def test_search_from_file
    assert_equal launcher.search_from_file(filename, 'name', 'bob'), [bob]
    assert_equal launcher.search_from_file(filename, 'id', '1'), [bob]
    assert_equal launcher.search_from_file(filename, 'hobbies', 'swim'), [bob]
    assert_equal launcher.search_from_file(filename, 'hobbies', 'code'), []
  end
end
