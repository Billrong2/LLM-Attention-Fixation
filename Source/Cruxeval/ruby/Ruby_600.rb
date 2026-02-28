def f(array)
    just_ns = array.map { |num| 'n' * num }
    final_output = []
    just_ns.each do |wipe|
        final_output.push(wipe)
    end
    final_output
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
