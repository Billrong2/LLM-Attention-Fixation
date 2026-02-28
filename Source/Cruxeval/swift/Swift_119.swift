/// 
func f(text: String) -> String {
    var result = ""
    for i in 0..<text.count {
        if i % 2 == 0 {
            result += String(text[text.index(text.startIndex, offsetBy: i)]).uppercased()
        } else {
            result += String(text[text.index(text.startIndex, offsetBy: i)])
        }
    }
    return result
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
            
assert(f(text: "vsnlygltaw") == "VsNlYgLtAw")
