/// 
func f(k: Int, j: Int) -> [Int] {
    var arr = [Int]()
    for _ in 0..<k {
        arr.append(j)
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
            
assert(f(k: 7, j: 5) == [5, 5, 5, 5, 5, 5, 5])
