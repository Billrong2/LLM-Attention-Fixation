def f(lines)
  lines.each_with_index do |line, i|
    lines[i] = line.center(lines[-1].length)
  end
  lines
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["dZwbSR", "wijHeq", "qluVok", "dxjxbF"], candidate.call(["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]))
  end
end
