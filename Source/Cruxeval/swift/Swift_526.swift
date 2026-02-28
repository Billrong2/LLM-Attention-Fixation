func f(label1: String, char: Character, label2: String, index: Int) -> String {
    if let m = label1.lastIndex(of: char) {
        let mIndex = label1.distance(from: label1.startIndex, to: m)
        if mIndex >= index {
            return String(label2.prefix(mIndex - index + 1))
        }
        let newIndex = label1.count + index - mIndex - 1
        return label1 + String(label2.suffix(from: label2.index(label2.startIndex, offsetBy: newIndex)))
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
            
assert(f(label1: "ekwies", char: "s", label2: "rpg", index: 1) == "rpg")
