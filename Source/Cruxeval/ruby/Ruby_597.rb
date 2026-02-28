def f(s)
    s.upcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1", candidate.call("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1"))
  end
end
