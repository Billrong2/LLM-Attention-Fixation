/// 
func f(text: String, suffix: String) -> Bool {
    if suffix == "" {
        let suffix: String? = nil
        return text.hasSuffix(suffix ?? "")
    } else {
        return text.hasSuffix(suffix)
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
            
assert(f(text: "uMeGndkGh", suffix: "kG") == false)
