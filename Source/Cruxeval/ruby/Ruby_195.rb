def f(text)
    ['acs', 'asp', 'scn'].each do |p|
        text = text.delete_prefix(p) + ' '
    end
    text.delete_prefix(' ')[0...-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ilfdoirwirmtoibsac  ", candidate.call("ilfdoirwirmtoibsac"))
  end
end
