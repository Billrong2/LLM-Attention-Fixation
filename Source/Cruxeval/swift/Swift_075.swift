/// 
func f(array: [Int], elem: Int) -> Int {
    let ind = array.firstIndex(of: elem)!
    return ind * 2 + array[array.count - ind - 1] * 3
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
            
assert(f(array: [-1, 2, 1, -8, 2], elem: 2) == -22)
