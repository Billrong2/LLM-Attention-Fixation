def f(array)
    prev = array[0]
    new_array = array.dup
    (1...array.length).each do |i|
        if prev != array[i]
            new_array[i] = array[i]
        else
            new_array.delete_at(i)
        end
        prev = array[i]
    end
    new_array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([1, 2, 3]))
  end
end
