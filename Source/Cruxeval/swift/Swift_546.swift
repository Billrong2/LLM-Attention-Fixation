/// 
func f(text: String, speaker: String) -> String {
    var updatedText = text
    while updatedText.hasPrefix(speaker) {
        updatedText = String(updatedText.dropFirst(speaker.count))
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
            
assert(f(text: "[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", speaker: "[CHARRUNNERS]") == "Do you know who the other was? [NEGMENDS]")
