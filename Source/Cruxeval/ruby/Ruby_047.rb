def f(text)
    length = text.length
    half = length / 2
    encode = text[0...half].encode('ascii')
    if text[half..-1] == encode.force_encoding('ascii').encode('ascii')
        return true
    else
        return false
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("bbbbr"))
  end
end
