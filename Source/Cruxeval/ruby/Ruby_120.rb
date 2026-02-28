def f(countries)
    language_country = {}
    countries.each do |country, language|
        language_country[language] ||= []
        language_country[language] << country
    end
    language_country
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}))
  end
end
