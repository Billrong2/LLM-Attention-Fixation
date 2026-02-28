/// 
func f(text: String, s: Int, e: Int) -> Int {
    let sublist = text[text.index(text.startIndex, offsetBy: s)..<text.index(text.startIndex, offsetBy: e)]
    if sublist.isEmpty {
        return -1
    }
    return text.distance(from: text.startIndex, to: sublist.firstIndex(of: sublist.min()!)!)
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
            
assert(f(text: "happy", s: 0, e: 3) == 1)
