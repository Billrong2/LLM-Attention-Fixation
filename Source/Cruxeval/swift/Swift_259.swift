/// 
func f(text: String) -> String {
    var new_text: [String] = []
    for character in text {
        if character.isUppercase {
            new_text.insert(String(character), at: new_text.count / 2)
        }
    }
    if new_text.isEmpty {
        new_text = ["-"]
    }
    return new_text.joined()
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
            
assert(f(text: "String matching is a big part of RexEx library.") == "RES")
