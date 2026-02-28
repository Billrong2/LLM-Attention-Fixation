def f
    d = {
        'Russia' => [['Moscow', 'Russia'], ['Vladivostok', 'Russia']],
        'Kazakhstan' => [['Astana', 'Kazakhstan']]
    }
    d.keys
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["Russia", "Kazakhstan"], candidate.call())
  end
end
