/// 
func f(text: String) -> String {
    if text.uppercased() == text {
        return "ALL UPPERCASE"
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
            
assert(f(text: "Hello Is It MyClass") == "Hello Is It MyClass")
