def f(text)
    new_text = []
    (text.length / 3).times do |i|
        new_text << "< #{text[i * 3, 3]} level=#{i} >"
    end
    last_item = text[text.length / 3 * 3..-1]
    new_text << "< #{last_item} level=#{text.length / 3} >"
    new_text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["< C7 level=0 >"], candidate.call("C7"))
  end
end
