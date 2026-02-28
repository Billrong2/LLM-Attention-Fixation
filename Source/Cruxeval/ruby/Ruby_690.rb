def f(n)
    if n.to_s.include?('.')
        (n.to_i + 2.5).to_s
    else
        n.to_s
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("800", candidate.call("800"))
  end
end
