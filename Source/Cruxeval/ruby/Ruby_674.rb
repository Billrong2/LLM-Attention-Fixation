def f(text)
    ls = text.split('')
    (ls.length-1).downto(0) do |x|
        break if ls.length <= 1
        ls.delete_at(x) if !('zyxwvutsrqponmlkjihgfedcba'.include? ls[x])
    end
    ls.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("qq", candidate.call("qq"))
  end
end
