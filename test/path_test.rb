require "minitest/autorun"
require "pry"

require_relative "../path"


class PathTest < MiniTest::Test
  def setup
    @path = Path.new
    @a = Vector2.new(1,1)
    @b = Vector2.new(10,10)    
  end

  def test_adding
    @path << @a << @b
    assert_equal 2, @path.size
  end

  def test_remove
    @path << @a << @b
    @path.remove(@a)
    assert_equal 1, @path.size
  end
end
