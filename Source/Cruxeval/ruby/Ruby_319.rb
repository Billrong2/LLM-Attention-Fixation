def f(needle, haystack)
    count = 0
    while haystack.include?(needle)
        haystack.sub!(needle, '')
        count += 1
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(4, candidate.call("a", "xxxaaxaaxx"))
  end
end
