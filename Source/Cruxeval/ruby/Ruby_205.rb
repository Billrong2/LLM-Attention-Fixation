def f(a)
    10.times do
        a.each_char.with_index do |char, index|
            if char != '#'
                a = a[index..-1]
                break
            end
        end
        a = "" if a.empty?
        break if a.empty?
    end
    a.chop! while a[-1] == '#'
    a
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("fiu##nk#he###wumun", candidate.call("##fiu##nk#he###wumun##"))
  end
end
