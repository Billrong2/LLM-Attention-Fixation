/// 
func f(value: String, char: String) -> Int {
    var total = 0
    for c in value {
        if c == Character(char) || c == Character(char.lowercased()) {
            total += 1
        }
    }
    return total
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
            
assert(f(value: "234rtccde", char: "e") == 1)
