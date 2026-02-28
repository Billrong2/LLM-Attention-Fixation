func f(dct: [String : String]) -> [String : String] {
    var result: [String: String] = [:]
    for (key, value) in dct {
        let item = value.split(separator: ".")[0] + "@pinc.uk"
        result[key] = String(item)
    }
    return result
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
            
assert(f(dct: [:] as [String : String]) == [:] as [String : String])
