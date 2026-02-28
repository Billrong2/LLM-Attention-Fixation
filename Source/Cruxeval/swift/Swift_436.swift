/// 
func f(s: String, characters: [Int]) -> [String] {
    return characters.map { index in
        String(s[String.Index(utf16Offset: index, in: s)])
    }
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
            
assert(f(s: "s7 6s 1ss", characters: [1, 3, 6, 1, 2]) == ["7", "6", "1", "7", " "])
