/// 
func f(array: [Int]) -> [Int] {
    var new_array = array
    new_array.reverse()
    return new_array.map { $0 * $0 }
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
            
assert(f(array: [1, 2, 1]) == [1, 4, 1])
