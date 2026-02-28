def f(names, excluded)
    names.each_with_index do |name, index|
        if name.include?(excluded)
            names[index] = name.gsub(excluded, "")
        end
    end
    names
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["avc  a .d e"], candidate.call(["avc  a .d e"], ""))
  end
end
