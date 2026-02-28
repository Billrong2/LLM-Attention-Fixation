func f(value: Int, width: Int) -> String {
    if value >= 0 {
        return String(repeating: "0", count: max(0, width - String(value).count)) + String(value)
    }
    
    if value < 0 {
        let absValue = -value
        return "-" + String(repeating: "0", count: max(0, width - 1 - String(absValue).count)) + String(absValue)
    }
    
    return ""
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
            
assert(f(value: 5, width: 1) == "5")
