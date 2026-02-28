def f(names)
    if names.empty?
        return ""
    end
    smallest = names[0]
    names[1..-1].each do |name|
        smallest = name if name < smallest
    end
    names.delete(smallest)
    smallest
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("", candidate.call([]))
  end
end
