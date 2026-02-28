/// 
func f(text: String, pref: String) -> String {
    let length = pref.count
    if pref == text.prefix(length) {
        return String(text.suffix(text.count - length))
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
            
assert(f(text: "kumwwfv", pref: "k") == "umwwfv")
