def f(book)
    a = book.rpartition(':')
    if a[0].split(' ')[-1] == a[2].split(' ')[0]
        return f(a[0].split(' ')[0...-1].join(' ') + ' ' + a[2])
    end
    return book
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("udhv zcvi nhtnfyd :erwuyawa pun", candidate.call("udhv zcvi nhtnfyd :erwuyawa pun"))
  end
end
