def f(tags)
  resp = ""
  tags.keys.each do |key|
    resp += key + " "
  end
  resp
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("3 4 ", candidate.call({"3" => "3", "4" => "5"}))
  end
end
