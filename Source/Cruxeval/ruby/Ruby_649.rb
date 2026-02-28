def f(text, tabsize)
    text.split("\n").map { |t| t.gsub(/\t/, ' ' * tabsize) }.join("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" f9
 ldf9
 adf9!
 f9?", candidate.call("	f9
	ldf9
	adf9!
	f9?", 1))
  end
end
