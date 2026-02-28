def f(lst)
    operation = Proc.new { |x| x.reverse! }
    new_list = lst.clone
    new_list.sort!
    operation.call(new_list)
    lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([6, 4, 2, 8, 15], candidate.call([6, 4, 2, 8, 15]))
  end
end
