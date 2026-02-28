/// 
func f(cities: [String], name: String) -> [String] {
    if name.isEmpty {
        return cities
    }
    if !name.isEmpty && name != "cities" {
        return []
    }
    return cities.map { name + $0 }
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
            
assert(f(cities: ["Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"], name: "Somewhere ") == [] as [String])
