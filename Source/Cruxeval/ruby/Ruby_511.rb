def f(fields, update_dict)
  di = fields.each_with_object({}) { |x, hash| hash[x] = '' }
  di.merge(update_dict)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"ct" => "", "c" => "", "ca" => "cx"}, candidate.call(["ct", "c", "ca"], {"ca" => "cx"}))
  end
end
