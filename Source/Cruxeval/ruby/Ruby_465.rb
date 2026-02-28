def f(seq, value)
  roles = Hash[seq.map { |key| [key, 'north'] }]
  roles.merge!(Hash[value.split(', ').map { |key| [key.strip, ''] }]) if value
  roles
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"wise king" => "north", "young king" => "north"}, candidate.call(["wise king", "young king"], ""))
  end
end
