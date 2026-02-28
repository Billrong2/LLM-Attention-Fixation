func f(val: String, text: String) -> Int {
    let indices = text.enumerated().compactMap { $0.element == val.first ? $0.offset : nil }
    if indices.isEmpty {
        return -1
    } else {
        return indices[0]
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
            
assert(f(val: "o", text: "fnmart") == -1)
