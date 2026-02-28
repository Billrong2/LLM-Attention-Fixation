/// 
func f(text: String) -> String {
    var out = ""
    for i in 0..<text.count {
        let char = text[text.index(text.startIndex, offsetBy: i)]
        if char.isUppercase {
            out.append(char.lowercased())
        } else {
            out.append(char.uppercased())
        }
    }
    return out
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
            
assert(f(text: ",wPzPppdl/") == ",WpZpPPDL/")
