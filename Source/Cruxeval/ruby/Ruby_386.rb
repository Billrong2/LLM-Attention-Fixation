def f(concat, di)
    count = di.length
    count.times do |i|
        if di[i.to_s].include?(concat)
            di.delete(i.to_s)
        end
    end
    return "Done!"
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Done!", candidate.call("mid", {"0" => "q", "1" => "f", "2" => "w", "3" => "i"}))
  end
end
