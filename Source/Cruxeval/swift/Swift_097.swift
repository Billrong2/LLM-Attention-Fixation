/// 
func f(lst: [Int]) -> Bool {
    var mutableList = lst
    mutableList.removeAll()
    
    for i in mutableList {
        if i == 3 {
            return false
        }
    }
    
    return true
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
            
assert(f(lst: [2, 0]) == true)
