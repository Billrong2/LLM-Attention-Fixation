def f(text, value)
    ls = text.split('')
    if (ls.count(value)) % 2 == 0
        while ls.include?(value)
            ls.delete(value)
        end
    else
        ls.clear
    end
    ls.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("abbkebaniuwurzvr", candidate.call("abbkebaniuwurzvr", "m"))
  end
end
