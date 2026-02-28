def f(line, char)
    count = line.count(char)
    (count+1).downto(1) do |i|
        line = line.center(line.length + i / char.length, char)
    end
    line
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("$$78$$", candidate.call("$78", "$"))
  end
end
