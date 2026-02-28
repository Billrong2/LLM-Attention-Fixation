def f(text)
    text.gsub("\n", "\t")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("apples			pears			bananas", candidate.call("apples
	
pears
	
bananas"))
  end
end
