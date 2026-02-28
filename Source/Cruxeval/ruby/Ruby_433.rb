def f(text)
    text = text.split(',')
    text.delete_at(0)
    text.insert(0, text.delete_at(text.index('T')))
    return 'T' + ',' + text.join(',')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("T,T,Sspp,G ,.tB,Vxk,Cct", candidate.call("Dmreh,Sspp,T,G ,.tB,Vxk,Cct"))
  end
end
