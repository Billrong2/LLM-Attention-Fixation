func f(array: [Int]) -> [Int] {
    var array = array
    while array.contains(-1) {
        if array.count > 2 { array.remove(at: array.index(array.endIndex, offsetBy: -3)) }
    }
    while array.contains(0) { array.popLast() }
    while array.contains(1) { array.removeFirst() }
    return array
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
            
assert(f(array: [0, 2]) == [] as [Int])
