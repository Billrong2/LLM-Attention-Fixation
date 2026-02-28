require 'set'

def f(items, target)
    items.split.each_with_index do |i, index|
        return index + 1 if target.include?(i)
        return 'error' if i.index('.') == i.length-1 || i.index('.') == 0
    end
    '.'
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("error", candidate.call("qy. dg. rnvprt rse.. irtwv tx..", "wtwdoacb"))
  end
end
