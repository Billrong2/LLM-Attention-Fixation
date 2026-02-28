def f(text)
    (text.length-1).times do |i|
        if text[i..-1].downcase == text[i..-1]
            return text[i+1..-1]
        end
    end
    ''
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("razugizoernmgzu", candidate.call("wrazugizoernmgzu"))
  end
end
