/// 
func f(text: String) -> String {
    var odd = ""
    var even = ""
    for (i, c) in text.enumerated() {
        if i % 2 == 0 {
            even.append(c)
        } else {
            odd.append(c)
        }
    }
    return even + odd.lowercased()
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
            
assert(f(text: "Mammoth") == "Mmohamt")
