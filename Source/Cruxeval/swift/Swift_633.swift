/// 
func f(array: [Int], elem: Int) -> Int {
    var reversedArray = array.reversed()
    if let foundIndex = reversedArray.firstIndex(of: elem) {
        return reversedArray.distance(from: reversedArray.startIndex, to: foundIndex)
    } else {
        return -1
    }
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
            
assert(f(array: [5, -3, 3, 2], elem: 2) == 0)
