func f(array: [String], arr: [String]) -> [String] {
    var result: [String] = []
    for s in arr {
        result += s.split(separator: Character(array[arr.firstIndex(of: s)!])).map { String($0) }.filter { $0 != "" }
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
            
assert(f(array: [] as [String], arr: [] as [String]) == [] as [String])
