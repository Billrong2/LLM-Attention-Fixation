func f(l1: [String], l2: [String]) -> [String : [String]] {
    if l1.count != l2.count {
        return [:]
    }
    var dictionary = [String: [String]]()
    for i in 0..<l1.count {
        dictionary[l1[i]] = l2
    }
    return dictionary
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
            
assert(f(l1: ["a", "b"], l2: ["car", "dog"]) == ["a" : ["car", "dog"], "b" : ["car", "dog"]])
