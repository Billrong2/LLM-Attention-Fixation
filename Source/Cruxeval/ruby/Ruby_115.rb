def f(text)
    res = []
    text.each_byte do |ch|
        if ch == 61
            break
        end
        if ch != 0
            res << "#{ch}; ".force_encoding('UTF-8')
        end
    end
    "b'#{res.join}'".force_encoding('UTF-8')
end

require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("b'111; 115; 124; 124; 97; 103; 120; 53; '", candidate.call("os||agx5"))
  end
end
