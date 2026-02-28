/// 
func f(items: [String]) -> [String] {
    var result: [String] = []
    for item in items {
        for d in item {
            if !d.isNumber {
                result.append(String(d))
            }
        }
    }
    return result
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
            
assert(f(items: ["123", "cat", "d dee"]) == ["c", "a", "t", "d", " ", "d", "e", "e"])
