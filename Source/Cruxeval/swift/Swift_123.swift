/// 
func f(array: [Int], elem: Int) -> [Int] {
    var newArray = array
    for (idx, e) in newArray.enumerated() {
        if e > elem && newArray[max(idx - 1, 0)] < elem {
            newArray.insert(elem, at: idx)
        }
    }
    return newArray
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
            
assert(f(array: [1, 2, 3, 5, 8], elem: 6) == [1, 2, 3, 5, 6, 8])
