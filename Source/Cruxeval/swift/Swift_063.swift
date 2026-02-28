/// 
func f(text: String, prefix: String) -> String {
    var text = text
    while text.hasPrefix(prefix) {
        let prefixCount = prefix.count
        let startIndex = text.index(text.startIndex, offsetBy: prefixCount)
        text = String(text[startIndex...]) ?? text
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
            
assert(f(text: "ndbtdabdahesyehu", prefix: "n") == "dbtdabdahesyehu")
