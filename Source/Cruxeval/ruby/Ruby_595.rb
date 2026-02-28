def f(text, prefix)
    if text.start_with?(prefix)
        text = text.delete_prefix(prefix)
    end
    text.capitalize
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Qdhstudentamxupuihbuztn", candidate.call("qdhstudentamxupuihbuztn", "jdm"))
  end
end
