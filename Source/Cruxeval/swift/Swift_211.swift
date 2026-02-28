/// 
func f(s: String) -> Int {
    var count = 0
    for char in s {
        if s.lastIndex(of: char) != s.firstIndex(of: char) {
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
            
assert(f(s: "abca dea ead") == 10)
