/// 
func f(m: [Int]) -> [Int] {
    var reversedArray = m
    reversedArray.reverse()
    return reversedArray
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
            
assert(f(m: [-4, 6, 0, 4, -7, 2, -1]) == [-1, 2, -7, 4, 0, 6, -4])
