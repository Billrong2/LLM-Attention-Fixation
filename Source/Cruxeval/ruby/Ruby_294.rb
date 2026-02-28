def f(n, m, text)
    if text.strip.empty?
        return text
    end
    head, mid, tail = text[0], text[1..-2], text[-1]
    joined = head.gsub(n, m) + mid.gsub(n, m) + tail.gsub(n, m)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("2$z&5H3*1a@#a*1hris", candidate.call("x", "$", "2xz&5H3*1a@#a*1hris"))
  end
end
