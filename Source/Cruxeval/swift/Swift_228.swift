func f(text: String, splitter: String) -> String {
    return text.lowercased().split(separator: " ").joined(separator: splitter)
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
            
assert(f(text: "LlTHH sAfLAPkPhtsWP", splitter: "#") == "llthh#saflapkphtswp")
