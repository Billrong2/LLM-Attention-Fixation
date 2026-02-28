def f(text, length, index)
    ls = text.rpartition(' ')[2]
    ls.split.map { |l| l[0, length] }.join('_')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hy", candidate.call("hypernimovichyp", 2, 2))
  end
end
