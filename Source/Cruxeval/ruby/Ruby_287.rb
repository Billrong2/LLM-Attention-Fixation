def f(name)
    if name.downcase == name
        name.upcase
    else
        name.downcase
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("pinneaple", candidate.call("Pinneaple"))
  end
end
