def f(array)
    zero_len = (array.length - 1) % 3
    zero_len.times { |i| array[i] = '0' }
    (zero_len + 1..array.length - 1).step(3) do |i|
        array[i..i + 2] = ['0', '0', '0']
    end
    array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["0", 2], candidate.call([9, 2]))
  end
end
