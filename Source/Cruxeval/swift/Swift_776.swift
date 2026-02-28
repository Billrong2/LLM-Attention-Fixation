func f(dictionary: [Int : Int]) -> [String : Int] {
    var a = dictionary
    var updatedDictionary: [String : Int] = [:]
    
    for (key, value) in a {
        if key % 2 != 0 {
            a.removeValue(forKey: key)
            updatedDictionary["$\(key)"] = value
        }
    }
    
    return updatedDictionary
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
            
assert(f(dictionary: [:] as [Int : Int]) == [:] as [String : Int])
