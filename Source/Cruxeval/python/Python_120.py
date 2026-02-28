from typing import Dict, List

def f(countries: Dict[str, str]) -> Dict[str, List[str]]:    
    language_country = dict()
    for country, language in countries.items():
        if language not in language_country:
            language_country[language] = []
        language_country[language].append(country)
    return language_country

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
