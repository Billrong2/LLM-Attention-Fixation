/// 
func f(postcode: String) -> String {
    if let index = postcode.firstIndex(of: "C") {
        return String(postcode[index...])
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
            
assert(f(postcode: "ED20 CW") == "CW")
