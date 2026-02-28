/// 
func f(text: String) -> String {
    for i in 0..<text.count {
        let index = text.index(text.startIndex, offsetBy: i)
        if text[..<index].hasPrefix("two") {
            let substringIndex = text.index(text.startIndex, offsetBy: i)
            return String(text[substringIndex...])
        }
    }
    return "no"
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
            
assert(f(text: "2two programmers") == "no")
