def f(text, chars)
    result = text.chars.to_a
    while result[-3] == chars
        result.delete_at(-3)
        result.delete_at(-3)
    end
    result.join('').chomp('.')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ellod!p.nkyp.exa.bi.y.hain", candidate.call("ellod!p.nkyp.exa.bi.y.hain", ".n.in.ha.y"))
  end
end
