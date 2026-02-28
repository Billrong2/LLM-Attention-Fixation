def f(text, suffix)
    if suffix && text && text.end_with?(suffix)
        text.delete_suffix(suffix)
    else
        text
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("spider", candidate.call("spider", "ed"))
  end
end
