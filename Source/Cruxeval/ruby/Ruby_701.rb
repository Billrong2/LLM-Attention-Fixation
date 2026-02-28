def f(stg, tabs)
    tabs.each do |tab|
        stg = stg.rstrip.chomp(tab)
    end
    stg
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("31849 let it!31849 pass!", candidate.call("31849 let it!31849 pass!", ["3", "1", "8", " ", "1", "9", "2", "d"]))
  end
end
