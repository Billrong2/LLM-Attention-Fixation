def f(text, chunks)
    text.split("\n", chunks)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["/alcm@ an)t//eprw)/e!/d", "ujv"], candidate.call("/alcm@ an)t//eprw)/e!/d
ujv", 0))
  end
end
