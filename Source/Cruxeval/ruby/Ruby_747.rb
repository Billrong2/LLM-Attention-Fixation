def f(text)
    if text == '42.42'
        true
    else
        (3...(text.length - 3)).each do |i|
            if text[i] == '.' && text[i - 3..-1].to_i.to_s == text[i - 3..-1] && text[0...i].to_i.to_s == text[0...i]
                return true
            end
        end
    end
    false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("123E-10"))
  end
end
