def f(commands)
  d = {}
  commands.each do |c|
    d.merge!(c)
  end
  d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"brown" => 2, "blue" => 5, "bright" => 4}, candidate.call([{"brown" => 2}, {"blue" => 5}, {"bright" => 4}]))
  end
end
