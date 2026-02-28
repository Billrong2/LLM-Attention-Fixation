def f(text)
    if text.split.map(&:capitalize).join(" ") != text
        return text.split.map(&:capitalize).join(" ")
    end
    return text.downcase
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Permission Is Granted", candidate.call("PermissioN is GRANTed"))
  end
end
