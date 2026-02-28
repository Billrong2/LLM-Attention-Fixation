def f(text)
    text = text.split('')
    text.each_with_index do |char, i|
        if i % 2 == 1
            text[i] = char.swapcase
        end
    end
    text.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("HEy Dude tHIs $Nd^ &*&tHiS@#", candidate.call("Hey DUdE THis $nd^ &*&this@#"))
  end
end
