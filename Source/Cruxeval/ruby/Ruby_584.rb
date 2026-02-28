def f(txt)
    txt % ['0'*20]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("5123807309875480094949830", candidate.call("5123807309875480094949830"))
  end
end
