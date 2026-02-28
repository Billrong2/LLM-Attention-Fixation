/// 
func f(text: String, characters: String) -> String {
    var textToModify = text
    for character in characters {
        while textToModify.hasSuffix(String(character)) {
            textToModify.removeLast()
        }
    }
    return textToModify
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
            
assert(f(text: "r;r;r;r;r;r;r;r;r", characters: "x.r") == "r;r;r;r;r;r;r;r;")
