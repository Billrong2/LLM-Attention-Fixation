/// 
func f(array: [Int]) -> [Int] {
    var result = array
    result.reverse()
    result = result.map { $0 * 2 }
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
            
assert(f(array: [1, 2, 3, 4, 5]) == [10, 8, 6, 4, 2])
