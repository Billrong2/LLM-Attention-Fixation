def f(full, part)
    length = part.length
    index = full.index(part)
    count = 0
    while index != nil
        full = full[(index + length)..-1]
        index = full.index(part)
        count += 1
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("hrsiajiajieihruejfhbrisvlmmy", "hr"))
  end
end
