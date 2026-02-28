def f(text)
    result = ""
    text.each_char.with_index do |char, i|
        if i.even?
            result += char.swapcase
        else
            result += char
        end
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("VsNlYgLtAw", candidate.call("vsnlygltaw"))
  end
end
