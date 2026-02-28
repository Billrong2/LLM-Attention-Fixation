func f(text: String) -> [String: Int] {
    var freq = [String: Int]()
    for c in text.lowercased() {
        let charString = String(c)
        if let count = freq[charString] {
            freq[charString] = count + 1
        } else {
            freq[charString] = 1
        }
    }
    return freq
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
            
assert(f(text: "HI") == ["h" : 1, "i" : 1])
