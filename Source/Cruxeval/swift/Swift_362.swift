/// 
func f(text: String) -> String {
    for i in 0..<(text.count - 1) {
        let startIndex = text.index(text.startIndex, offsetBy: i)
        if text[startIndex...].lowercased() == text[startIndex...] {
            let nextIndex = text.index(startIndex, offsetBy: 1)
            return String(text[nextIndex...])
        }
    }
    return ""
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
            
assert(f(text: "wrazugizoernmgzu") == "razugizoernmgzu")
