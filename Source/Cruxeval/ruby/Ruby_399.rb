def f(text, old, new)
    if old.size > 3
        return text
    end

    if text.include?(old) && !text.include?(' ')
        return text.gsub(old, new * old.size)
    end

    while text.include?(old)
        text = text.gsub(old, new)
    end

    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("a--cado", candidate.call("avacado", "va", "-"))
  end
end
