/// 
func f(text: String, suffix: String) -> String {
    if text.hasSuffix(suffix) {
        return String(text.dropLast(suffix.count))
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
            
assert(f(text: "zejrohaj", suffix: "owc") == "zejrohaj")
