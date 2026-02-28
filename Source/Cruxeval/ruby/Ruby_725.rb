def f(text)
    result_list = ['3', '3', '3', '3']
    result_list.clear unless result_list.empty?
    text.length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(5, candidate.call("mrq7y"))
  end
end
