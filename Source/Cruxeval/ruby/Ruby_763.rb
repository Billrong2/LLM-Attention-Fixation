def f(values, text, markers)
  text = text.gsub(/[#{values}]+$/, '')
  text = text.gsub(/[#{markers}]+$/, '') unless markers.empty?
  text
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("yCxpg2C2Pny", candidate.call("2Pn", "yCxpg2C2Pny2", ""))
  end
end
