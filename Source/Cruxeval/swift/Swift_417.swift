/// 
func f(lst: [Int]) -> [Int] {
    var mutableList = lst
    mutableList.reverse()
    mutableList.removeLast()
    mutableList.reverse()
    return mutableList
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
            
assert(f(lst: [7, 8, 2, 8]) == [8, 2, 8])
