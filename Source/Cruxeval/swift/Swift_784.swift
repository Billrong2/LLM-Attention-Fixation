/// 
func f(key: String, value: String) -> (String, String) {
    var dict: [String: String] = [key: value]
    let item = dict.removeValue(forKey: key)
    return (key, item ?? "")
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
            
assert(f(key: "read", value: "Is") == ("read", "Is"))
