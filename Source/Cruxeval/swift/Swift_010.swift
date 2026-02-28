/// 
func f(text: String) -> String {
    return text.lowercased().filter{ "ÄäÏïÖ�Ü�".contains($0) || $0.isNumber }
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
            
assert(f(text: "") == "")
