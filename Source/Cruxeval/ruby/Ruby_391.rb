def f(students)
  seatlist = students.reverse
  cnt = 0
  for cnt in 0...seatlist.length
    cnt += 2
    seatlist[cnt - 1, 1] = ['+']
  end
  seatlist.push('+')
  seatlist
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["9", "+", "+", "+"], candidate.call(["r", "9"]))
  end
end
