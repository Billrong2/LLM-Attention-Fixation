def f(string)
    return 'INVALID' if string.nil? || string[0] !~ /\d/
    cur = 0
    string.chars.each do |char|
        cur = cur * 10 + char.to_i
    end
    cur.to_s
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("3", candidate.call("3"))
  end
end
