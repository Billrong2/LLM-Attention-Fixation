/// 
func f(haystack: String, needle: String) -> Int {
    for i in stride(from: haystack.count - needle.count, through: 0, by: -1) {
        if haystack.suffix(from: haystack.index(haystack.startIndex, offsetBy: i)) == needle {
            return i
        }
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
            
assert(f(haystack: "345gerghjehg", needle: "345") == -1)
