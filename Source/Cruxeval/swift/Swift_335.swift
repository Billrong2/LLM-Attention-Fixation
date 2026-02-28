/// 
func f(text: String, to_remove: String) -> String {
    var new_text = Array(text)
    if new_text.contains(Character(to_remove)) {
        if let index = new_text.firstIndex(of: Character(to_remove)) {
            new_text.remove(at: index)
            new_text.insert("?", at: index)
            if let questionMarkIndex = new_text.firstIndex(of: "?") {
                new_text.remove(at: questionMarkIndex)
            }
        }
    }
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
            
assert(f(text: "sjbrlfqmw", to_remove: "l") == "sjbrfqmw")
