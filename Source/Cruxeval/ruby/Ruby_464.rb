def f(ans)
    if ans.match?(/^\d+$/)
        total = ans.to_i * 4 - 50
        total -= ans.chars.count { |c| c !~ /[02468]/ } * 100
        return total
    end
    'NAN'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-50, candidate.call("0"))
  end
end
