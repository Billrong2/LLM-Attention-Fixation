/// 
func f(text: String, value: String) -> Int {
    if let _ = value as? String {
        return text.filter { $0.lowercased() == value.lowercased() }.count
    }
    return 0
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
            
assert(f(text: "eftw{ьТсk_1", value: "\\") == 0)
