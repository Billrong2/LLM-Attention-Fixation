/// 
func f(lst: [Int]) -> [Int] {
    var sortedList = lst.sorted()
    return Array(sortedList.prefix(3))
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
            
assert(f(lst: [5, 8, 1, 3, 0]) == [0, 1, 3])
