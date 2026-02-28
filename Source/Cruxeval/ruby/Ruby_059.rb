def f(s)
    a = s.chars.select { |char| char != ' ' }
    b = a.dup
    a.reverse_each do |c|
        if c == ' '
            b.pop
        else
            break
        end
    end
    b.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hi", candidate.call("hi "))
  end
end
