extension String: Error {}
        
/// 
func f(list1: [Int], list2: [Int]) -> Result<Int, String> {
    var l = list1
    while !l.isEmpty {
        if list2.contains(l.last!) {
            l.removeLast()
        } else {
            return .success(l.last!)
        }
    }
    return .failure("missing")
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
            
assert(f(list1: [0, 4, 5, 6], list2: [13, 23, -5, 0]) == .success(6))
