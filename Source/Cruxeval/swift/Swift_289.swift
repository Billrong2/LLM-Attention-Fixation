/// 
func f(code: String) -> String {
    let encoded = code.utf8
    let encodedString = "b'\(encoded)'"
    return "\(code): \(encodedString)"
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
            
assert(f(code: "148") == "148: b'148'")
