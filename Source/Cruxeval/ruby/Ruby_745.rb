def f(address)
    suffix_start = address.index('@') + 1
    if address[suffix_start..].count('.') > 1
        address = address.chomp(".".join(address.split('@')[1].split('.')[0, 2]))
    end
    address
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("minimc@minimc.io", candidate.call("minimc@minimc.io"))
  end
end
