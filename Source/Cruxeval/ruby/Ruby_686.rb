def f(d, l)
    new_d = {}

    l.each do |k|
        if d[k]
            new_d[k] = d[k]
        end
    end

    new_d.dup
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"lorem ipsum" => 12, "dolor" => 23}, candidate.call({"lorem ipsum" => 12, "dolor" => 23}, ["lorem ipsum", "dolor"]))
  end
end
