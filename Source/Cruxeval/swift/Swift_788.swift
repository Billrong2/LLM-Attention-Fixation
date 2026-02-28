/// 
func f(text: String, suffix: String) -> String {
    if suffix.hasPrefix("/") {
        return text + String(suffix.dropFirst())
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
            
assert(f(text: "hello.txt", suffix: "/") == "hello.txt")
