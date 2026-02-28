/// 
func f(zoo: [String : String]) -> [String : String] {
    return Dictionary(uniqueKeysWithValues: zoo.map({ ($1, $0) }))
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
            
assert(f(zoo: ["AAA" : "fr"]) == ["fr" : "AAA"])
