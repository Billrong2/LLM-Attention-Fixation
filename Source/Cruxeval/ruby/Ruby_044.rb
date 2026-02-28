def f(text)
    ls = text.split('')
    ls.each_with_index do |char, i|
        if char != '+'
            ls.insert(i, '+')
            ls.insert(i, '*')
            break
        end
    end
    ls.join('+')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("*+++n+z+o+h", candidate.call("nzoh"))
  end
end
