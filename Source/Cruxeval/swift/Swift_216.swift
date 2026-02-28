/// 
func f(letters: String) -> Int {
    var count = 0
    for l in letters {
        if l.isNumber {
            count += 1
        }
    }
    return count
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
            
assert(f(letters: "dp ef1 gh2") == 2)
