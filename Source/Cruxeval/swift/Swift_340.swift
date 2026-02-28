/// 
func f(text: String) -> String {
    if let uppercaseIndex = text.firstIndex(of: "A") {
        return String(text[..<uppercaseIndex]) + text[text.index(after: text.firstIndex(of: "a")!)...]
    } else {
        return String(text.sorted())
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
            
assert(f(text: "E jIkx HtDpV G") == "   DEGHIVjkptx")
