def f(text)
    (0..text.length).each do |i|
        return text[i..-1] if text[0...i].start_with?("two")
    end
    'no'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("no", candidate.call("2two programmers"))
  end
end
