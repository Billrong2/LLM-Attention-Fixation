def f(text, symbols)
    count = 0
    if symbols != ''
        count = symbols.length
        text = text * count
    end
    text.rjust(text.length + count*2)[0...-2]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("        ", candidate.call("", "BC1ty"))
  end
end
