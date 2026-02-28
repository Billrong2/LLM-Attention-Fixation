func f(n: Int) -> [Double] {
    let values: [Int: Double] = [0: 3, 1: 4.5, 2: -1]
    var res = [Double: Int]()
    
    for (i, j) in values {
        if i % n != 2 {
            res[j] = n / 2
        }
    }
    
    return res.keys.sorted()
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
            
assert(f(n: 12) == [3, 4.5])
