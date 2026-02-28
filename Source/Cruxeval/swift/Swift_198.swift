/// 
func f(text: String, strip_chars: String) -> String {
    return String(text.reversed().drop(while: { strip_chars.contains($0) }).reversed())
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
            
assert(f(text: "tcmfsmj", strip_chars: "cfj") == "tcmfsm")
