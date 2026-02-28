def f(array)
    c = array
    array_copy = array

    loop do
        c << '_'
        if c == array_copy
            array_copy[c.index('_')] = ''
            break
        end
    end

    array_copy
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([""], candidate.call([]))
  end
end
