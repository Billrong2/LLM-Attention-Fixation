func f(array: [(Int, Int)]) -> [Int : Int]? {
    var d = Dictionary(array, uniquingKeysWith: { (oldValue, newValue) in newValue })
    for (key, value) in d {
        if value < 0 || value > 9 {
            return nil
        }
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
            
assert(f(array: [(8, 5), (8, 2), (5, 3)]) == [8 : 2, 5 : 3])
