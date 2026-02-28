/// 
func f(text: String, char: String) -> String {
    var textArray = Array(text)
    for (index, item) in textArray.enumerated() {
        if item == Character(char) {
            textArray.remove(at: index)
            return String(textArray)
        }
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
            
assert(f(text: "pn", char: "p") == "n")
