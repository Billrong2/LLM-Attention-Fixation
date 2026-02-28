/// 
func f(numbers: String) -> Int {
    for i in 0..<numbers.count {
        if numbers.filter({$0 == "3"}).count > 1 {
            return i
        }
    }
    return -1
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
            
assert(f(numbers: "23157") == -1)
