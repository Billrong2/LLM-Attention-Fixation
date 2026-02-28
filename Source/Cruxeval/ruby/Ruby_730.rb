def f(text)
    m = 0
    cnt = 0
    text.split.each do |i|
        if i.length > m
            cnt += 1
            m = i.length
        end
    end
    cnt
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl"))
  end
end
