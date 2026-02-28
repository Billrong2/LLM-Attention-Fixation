def f(s, amount)
    lines = s.lines.to_a
    w = lines.max_by { |l| l.rindex(' ') || -1 }.rindex(' ') || -1
    ls = lines.map { |l| [l.strip, (w + 1) * amount - (l.rindex(' ') || -1)] }
    ls.each_with_index { |line, i| ls[i][0] = line[0] + ' ' * line[1] }
    ls.map { |l| l[0] }.join("\n")
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" ", candidate.call("
", 2))
  end
end
