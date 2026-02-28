def f(text)
    count = text.length
    for i in (-count+1..-1)
        text += text[i]
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("wlace Alc l  ", candidate.call("wlace A"))
  end
end
