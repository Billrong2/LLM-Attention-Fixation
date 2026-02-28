def f(lst)
    original = lst.dup
    while lst.length > 1
        lst.delete_at(lst.length - 1)
        lst.each_with_index { |_, i| lst.delete_at(i) }
    end
    lst = original.dup
    lst.shift if !lst.empty?
    lst
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
