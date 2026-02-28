///
func f(d: [String : [AnyHashable]]) -> [String : [AnyHashable]] {
    var result: [String : [AnyHashable]] = [:]
    for (ki, li) in d {
        result.updateValue([], forKey: ki)
        for (kj, dj) in li.enumerated() {
            guard var temp = result[ki] else {
                continue
            }
            temp.append(dj)
            result[ki] = temp
        }
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
            
assert(f(d: [:] as [String : [AnyHashable]]) == [:] as [String : [AnyHashable]])
