def f(container, cron)
    unless container.include?(cron)
        return container
    end
    pref = container[0...container.index(cron)].dup
    suff = container[container.index(cron) + 1..-1].dup
    pref + suff
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([], 2))
  end
end
