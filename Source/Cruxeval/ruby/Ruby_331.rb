def f(strand, zmnc)
    poz = strand.index(zmnc) || -1
    while poz != -1
        strand = strand[(poz + 1)..-1]
        poz = strand.index(zmnc) || -1
    end
    strand.rindex(zmnc) || -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("", "abc"))
  end
end
