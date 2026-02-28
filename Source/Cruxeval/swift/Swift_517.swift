/// 
func f(text: String) -> String {
    for i in (0..<text.count).reversed() {
        let index = text.index(text.startIndex, offsetBy: i)
        if !text[index].isUppercase {
            return String(text[..<index])
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
            
assert(f(text: "SzHjifnzog") == "SzHjifnzo")
