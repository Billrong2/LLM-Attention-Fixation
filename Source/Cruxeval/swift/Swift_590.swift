/// 
func f(text: String) -> String {
    var updatedText = text
    for i in (0...9).reversed() {
        let charToRemove = Character(String(i))
        while updatedText.first == charToRemove {
            updatedText.removeFirst()
        }
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
            
assert(f(text: "25000   $") == "5000   $")
