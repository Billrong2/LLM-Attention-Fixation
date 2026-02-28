def f(instagram, imgur, wins)
    photos = [instagram, imgur]
    if instagram == imgur
        return wins
    end
    if wins == 1
        return photos.pop
    else
        photos.reverse!
        return photos.pop
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["sdfs", "drcr", "2e"], candidate.call(["sdfs", "drcr", "2e"], ["sdfs", "dr2c", "QWERTY"], 0))
  end
end
