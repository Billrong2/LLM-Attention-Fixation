def f(item)
  modified = item.gsub('. ', ' , ').gsub('&#33; ', '! ').gsub('. ', '? ').gsub('. ', '. ')
  modified[0] = modified[0].upcase
  modified
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(".,,,,, , منبت", candidate.call(".,,,,,. منبت"))
  end
end
