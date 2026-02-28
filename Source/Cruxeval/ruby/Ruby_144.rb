def f(vectors)
    sorted_vecs = []
    vectors.each do |vec|
        vec.sort!
        sorted_vecs << vec
    end
    sorted_vecs
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end
