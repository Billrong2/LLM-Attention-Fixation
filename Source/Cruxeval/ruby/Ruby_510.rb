def f(a, b, c, d, e)
    key = d
    num = nil
    if a.has_key?(key)
        num = a.delete(key)
    end
    if b > 3
        return c.to_s
    else
        return num
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Wy", candidate.call({7 => "ii5p", 1 => "o3Jwus", 3 => "lot9L", 2 => "04g", 9 => "Wjf", 8 => "5b", 0 => "te6", 5 => "flLO", 6 => "jq", 4 => "vfa0tW"}, 4, "Wy", "Wy", 1.0))
  end
end
