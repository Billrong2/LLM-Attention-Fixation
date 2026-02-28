/// 
func f(text: String, char: String, min_count: Int) -> String {
    let count = text.filter { $0 == Character(char) }.count
    if count < min_count {
        return text.uppercased()
    }
    return text
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
            
assert(f(text: "wwwwhhhtttpp", char: "w", min_count: 3) == "wwwwhhhtttpp")
