func f(text: String, char: String) -> Int {
    if let index = text.lastIndex(of: Character(char)) {
        return text.distance(from: text.startIndex, to: index)
    } else {
        return -1 // or any other appropriate value to indicate character not found
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
            
assert(f(text: "breakfast", char: "e") == 2)
