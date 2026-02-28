def f(n, m, num)
    x_list = (n..m).to_a
    j = 0
    loop do
        j = (j + num) % x_list.length
        if x_list[j] % 2 == 0
            return x_list[j]
        end
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(46, candidate.call(46, 48, 21))
  end
end
