/// 
func f(array: [Int], ind: Int, elem: Int) -> [Int] {
    var updatedArray = array
    updatedArray.insert(elem, at: ind < 0 ? -5 : ind > array.count ? array.count : ind + 1)
    return updatedArray
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
            
assert(f(array: [1, 5, 8, 2, 0, 3], ind: 2, elem: 7) == [1, 5, 8, 7, 2, 0, 3])
