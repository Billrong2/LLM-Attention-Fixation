def f(name)
    new_name = ''
    name = name.reverse
    name.each_char.with_index do |n, i|
        if n != '.' && new_name.count('.') < 2
            new_name = n + new_name
        else
            break
        end
    end
    new_name
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("NET", candidate.call(".NET"))
  end
end
