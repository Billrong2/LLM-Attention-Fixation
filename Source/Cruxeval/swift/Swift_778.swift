/// 
func f(prefix: String, text: String) -> String {
    if text.hasPrefix(prefix) {
        return text
    } else {
        return prefix + text
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
            
assert(f(prefix: "mjs", text: "mjqwmjsqjwisojqwiso") == "mjsmjqwmjsqjwisojqwiso")
