func f(dic: [Int : Int]) -> [Int : Int] {
    var d: [Int : Int] = [:]
    for key in dic.keys {
        d[key] = dic[key] ?? 0
    }
    return d
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
            
assert(f(dic: [:] as [Int : Int]) == [:] as [Int : Int])
