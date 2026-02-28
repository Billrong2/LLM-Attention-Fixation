/// 
func f(strings: [String]) -> [String] {
    var newStrings: [String] = []
    for string in strings {
        let firstTwo = String(string.prefix(2))
        if firstTwo.hasPrefix("a") || firstTwo.hasPrefix("p") {
            newStrings.append(firstTwo)
        }
    }
    
    return newStrings
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
            
assert(f(strings: ["a", "b", "car", "d"]) == ["a"])
