/// 
func f(lst: [Int], i: Int, n: Int) -> [Int] {
    var updatedList = lst
    updatedList.insert(n, at: i)
    return updatedList
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
            
assert(f(lst: [44, 34, 23, 82, 24, 11, 63, 99], i: 4, n: 15) == [44, 34, 23, 82, 15, 24, 11, 63, 99])
