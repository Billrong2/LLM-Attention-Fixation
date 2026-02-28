def f(data)
    members = []
    data.each do |item, values|
        values.each do |member|
            if !members.include?(member)
                members << member
            end
        end
    end
    members.sort
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["a", "b", "c", "inf"], candidate.call({"inf" => ["a", "b"], "a" => ["inf", "c"], "d" => ["inf"]}))
  end
end
