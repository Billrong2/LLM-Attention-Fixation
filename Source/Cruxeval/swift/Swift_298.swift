/// 
func f(text: String) -> String {
    var new_text = Array(text)
    for i in 0..<new_text.count {
        let character = new_text[i]
        let new_character = String(character).uppercased() == String(character) ? String(character).lowercased() : String(character).uppercased()
        new_text[i] = Character(new_character)
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
            
assert(f(text: "dst vavf n dmv dfvm gamcu dgcvb.") == "DST VAVF N DMV DFVM GAMCU DGCVB.")
