def f(string, prefix)
    if string.start_with?(prefix)
        string.delete_prefix(prefix)
    else
        string
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Vipra", candidate.call("Vipra", "via"))
  end
end
