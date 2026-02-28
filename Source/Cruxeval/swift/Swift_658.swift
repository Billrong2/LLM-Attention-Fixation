func f(d: [Int : String], get_ary: [Int]) -> [String?] {
    var result: [String?] = []
    for key in get_ary {
        result.append(d[key])
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
            
assert(f(d: [3 : "swims like a bull"], get_ary: [3, 2, 5]) == ["swims like a bull", nil, nil])
