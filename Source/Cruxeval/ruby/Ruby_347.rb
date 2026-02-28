def f(text)
    ls = text.split('')
    length = ls.length
    length.times do |i|
        ls.insert(i, ls[i])
    end
    ls.join('').ljust(length * 2)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("hhhhhzcw", candidate.call("hzcw"))
  end
end
