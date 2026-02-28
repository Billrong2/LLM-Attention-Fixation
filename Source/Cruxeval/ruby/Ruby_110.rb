def f(text)
  a = ['']
  b = ''
  text.each_char do |i|
    if !i.match(/\s/)
      a << b
      b = ''
    else
      b += i
    end
  end
  a.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("       "))
  end
end
