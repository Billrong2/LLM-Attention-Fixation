func f(text: String) -> Int {
    if let index = text.firstIndex(of: ",") {
        return text.distance(from: text.startIndex, to: index)
    } else {
        return -1
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
            
assert(f(text: "There are, no, commas, in this text") == 9)
