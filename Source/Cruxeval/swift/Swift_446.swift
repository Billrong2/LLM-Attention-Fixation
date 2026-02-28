/// 
func f(array: [Int]) -> [Int] {
    var newArray = array
    let l = newArray.count
    if l % 2 == 0 {
        newArray.removeAll()
    } else {
        newArray.reverse()
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
            
assert(f(array: [] as [Int]) == [] as [Int])
