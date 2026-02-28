def f(dictionary, arr)
    dictionary[arr[0]] = [arr[1]]
    if dictionary[arr[0]].length == arr[1]
        dictionary[arr[0]] = arr[0]
    end
    return dictionary
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"a" => [2]}, candidate.call({}, ["a", 2]))
  end
end
