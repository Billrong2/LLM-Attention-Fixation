/// 
func f(d: [Int : String]) -> [Int : String] {
    var r: [Int: String] = [:]
    var mutableDictionary = d
    
    while !mutableDictionary.isEmpty {
        r.merge(mutableDictionary) { _, new in new }
        mutableDictionary.removeValue(forKey: mutableDictionary.keys.max()!)
    }
    
    return r
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
            
assert(f(d: [3 : "A3", 1 : "A1", 2 : "A2"]) == [3 : "A3", 1 : "A1", 2 : "A2"])
