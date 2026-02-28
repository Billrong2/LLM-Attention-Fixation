def f(string)
    if string[0, 4] != 'Nuva'
        'no'
    else
        string.rstrip
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Nuva?dlfuyjys", candidate.call("Nuva?dlfuyjys"))
  end
end
