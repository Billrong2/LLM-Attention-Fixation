def f(text)
    rtext = text.split('')
    (1..rtext.length - 2).each do |i|
        rtext.insert(i + 1, '|')
    end
    rtext.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("px|||||cznyf", candidate.call("pxcznyf"))
  end
end
