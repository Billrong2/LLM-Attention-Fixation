/// 
func f(n: Int, m: Int) -> [Int] {
    var arr = Array(1...n)
    for _ in 0..<m {
        arr.removeAll()
    }
    return arr
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
            
assert(f(n: 1, m: 3) == [] as [Int])
