func f(text: String, elem: String) -> [String] {
    var mutableText = text
    var mutableElem = elem
    
    if elem != "" {
        while mutableText.hasPrefix(elem) {
            mutableText = String(mutableText.dropFirst(elem.count))
        }
        while mutableElem.hasPrefix(text) {
            mutableElem = String(mutableElem.dropFirst(text.count))
        }
    }
    return [mutableElem, mutableText]
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
            
assert(f(text: "some", elem: "1") == ["1", "some"])
