/// 
func f(items: [String], target: String) -> Int {
    if let index = items.firstIndex(of: target) {
        return index
    }
    return -1
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
            
assert(f(items: ["1", "+", "-", "**", "//", "*", "+"], target: "**") == 3)
