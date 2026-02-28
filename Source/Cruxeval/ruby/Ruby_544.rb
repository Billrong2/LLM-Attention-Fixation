def f(text)
    a = text.split("\n")
    b = []
    a.each do |line|
        c = line.gsub("\t", "    ")
        b << c
    end
    b.join("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("            tab tab tabulates", candidate.call("			tab tab tabulates"))
  end
end
