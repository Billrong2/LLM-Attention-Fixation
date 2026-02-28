def f(counts)
    new_counts = {}
    counts.each do |k, v|
        count = counts[k]
        if !new_counts.key?(count)
            new_counts[count] = []
        end
        new_counts[count] << k
    end
    counts.merge!(new_counts)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"2" => 2, "0" => 1, "1" => 2, 2 => ["2", "1"], 1 => ["0"]}, candidate.call({"2" => 2, "0" => 1, "1" => 2}))
  end
end
