/// 
func f(char_map: [String : String], text: String) -> String {
    var new_text = ""
    for ch in text {
        if let val = char_map[String(ch)] {
            new_text += val
        } else {
            new_text += String(ch)
        }
    }
    return new_text
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
            
assert(f(char_map: [:] as [String : String], text: "hbd") == "hbd")
