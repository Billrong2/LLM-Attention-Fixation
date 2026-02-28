/// 
func f(array: [Int], n: Int) -> [Int] {
    return Array(array[n...])
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
            
assert(f(array: [0, 0, 1, 2, 2, 2, 2], n: 4) == [2, 2, 2])
