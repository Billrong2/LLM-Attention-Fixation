/// 
func f(text: String, count: Int) -> String {
    var updatedText = text
    for _ in 0..<count {
        updatedText = String(updatedText.reversed())
    }
    return updatedText
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
            
assert(f(text: "aBc, ,SzY", count: 2) == "aBc, ,SzY")
