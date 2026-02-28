def f(alphabet, s)
  a = alphabet.chars.select { |x| x.upcase == x && s.upcase.include?(x) }
  a << 'all_uppercased' if s.upcase == s
  a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call("abcdefghijklmnopqrstuvwxyz", "uppercased # % ^ @ ! vz."))
  end
end
