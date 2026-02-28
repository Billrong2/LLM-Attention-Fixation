def f(text)
    (10.downto(1)).each do |i|
        text = text.gsub(/^#{i}/, '')
    end
    text
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("5000   $", candidate.call("25000   $"))
  end
end
