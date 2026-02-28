/// 
func f(countries: [String : String]) -> [String : [String]] {
    var language_country = [String: [String]]()
    
    for (country, language) in countries {
        if language_country[language] == nil {
            language_country[language] = []
        }
        language_country[language]?.append(country)
    }
    
    return language_country
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(countries: [:] as [String : String]) == [:] as [String : [String]])
