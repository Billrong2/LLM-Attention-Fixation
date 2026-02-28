func f(text: String, char: String) -> Int {
    var position = text.count
    if let character = char.first, text.contains(character) {
        if let index = text.firstIndex(of: character) {
            position = text.distance(from: text.startIndex, to: index)
            if position > 1 {
                position = (position + 1) % text.count
            }
        }
    }
    return position
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
            
assert(f(text: "wduhzxlfk", char: "w") == 0)
