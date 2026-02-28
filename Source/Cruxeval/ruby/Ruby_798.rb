def f(text, pre)
    if !text.start_with?(pre)
        text
    else
        text.delete_prefix(pre)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("@!", candidate.call("@hihu@!", "@hihu"))
  end
end
