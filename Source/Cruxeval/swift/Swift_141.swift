/// 
func f(li: [String]) -> [Int] {
    return li.map({item in li.filter({$0 == item}).count})
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
            
assert(f(li: ["k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g"]) == [1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1])
