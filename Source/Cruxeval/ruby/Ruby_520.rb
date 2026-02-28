def f(album_sales)
    while album_sales.length != 1
        album_sales.push(album_sales.shift)
    end
    album_sales[0]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(6, candidate.call([6]))
  end
end
