def f(str, toget)
    if str.start_with?(toget)
        str[toget.length..-1]
    else
        str
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("fnuiyh", candidate.call("fnuiyh", "ni"))
  end
end
