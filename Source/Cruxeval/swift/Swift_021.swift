/// 
func f(array: [Int]) -> [Int] {
    var newArray = array
    let n = newArray.removeLast()
    newArray.append(contentsOf: [n, n])
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
            
assert(f(array: [1, 1, 2, 2]) == [1, 1, 2, 2, 2])
