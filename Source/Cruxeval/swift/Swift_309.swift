/// 
func f(text: String, suffix: String) -> String {
    var updatedText = text + suffix
    while updatedText.hasSuffix(suffix) {
        updatedText = String(updatedText.dropLast())
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
            
assert(f(text: "faqo osax f", suffix: "f") == "faqo osax ")
