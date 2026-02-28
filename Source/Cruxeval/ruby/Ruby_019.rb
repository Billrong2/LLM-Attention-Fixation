def f(x, y)
    tmp = y.reverse.gsub('9', '0').gsub('0', '9')
    if (x.match?(/\A\d+\z/) && tmp.match?(/\A\d+\z/))
        return x + tmp
    else
        return x
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call("", "sdasdnakjsda80"))
  end
end
