/// 
func f(text: String) -> String {
    var rtext = Array(text)
    for i in 1..<(rtext.count - 1) {
        rtext.insert("|", at: i + 1)
    }
    return String(rtext)
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
            
assert(f(text: "pxcznyf") == "px|||||cznyf")
