/// 
func f(arr: [Int]) -> [Int] {
    return arr.reversed()
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
            
assert(f(arr: [2, 0, 1, 9999, 3, -5]) == [-5, 3, 9999, 1, 0, 2])
