/// 
func f(text: String, pref: String) -> Bool {
    if let prefList = pref as? [String] {
        return prefList.map({ text.hasPrefix($0) ? "true" : "false" }).joined(separator: ", ") == "true"
    } else {
        return text.hasPrefix(pref)
    }
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
            
assert(f(text: "Hello World", pref: "W") == false)
