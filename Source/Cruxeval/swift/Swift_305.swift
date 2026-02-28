/// 
func f(text: String, char: String) -> String {
    var length = text.count
    var index = -1
    for (i, character) in text.enumerated() {
        if String(character) == char {
            index = i
        }
    }
    if index == -1 {
        index = length / 2
    }
    var new_text = Array(text)
    new_text.remove(at: index)
    return String(new_text)
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
            
assert(f(text: "o horseto", char: "r") == "o hoseto")
