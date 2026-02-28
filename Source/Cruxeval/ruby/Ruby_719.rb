def f(code)
    lines = code.split(']')
    result = []
    level = 0
    lines.each do |line|
        result << line[0] + ' ' + '  ' * level + line[1..-1]
        level += line.count('{') - line.count('}')
    end
    result.join("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("i f (x) {y = 1;} else {z = 1;}", candidate.call("if (x) {y = 1;} else {z = 1;}"))
  end
end
