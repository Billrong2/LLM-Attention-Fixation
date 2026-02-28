/// 
func f(mylist: [Int]) -> Bool {
    var revl = mylist
    revl.reverse()
    var sortedList = mylist.sorted(by: >)
    return sortedList == revl
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
            
assert(f(mylist: [5, 8]) == true)
