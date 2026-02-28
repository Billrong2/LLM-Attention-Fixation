def f(string, encryption)
    if encryption == 0
        string
    else
        string.upcase.tr('A-Z', 'N-ZA-M')
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("UppEr", candidate.call("UppEr", 0))
  end
end
