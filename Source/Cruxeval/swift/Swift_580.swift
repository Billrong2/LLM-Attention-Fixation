func f(text: String, char: String) -> [Int] {
    var new_text = text
    var a: [Int] = []
    while new_text.contains(Character(char)) {
        if let index = new_text.firstIndex(of: Character(char)) {
            a.append(new_text.distance(from: new_text.startIndex, to: index))
            new_text.remove(at: index)
        }
    }
    return a
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
            
assert(f(text: "rvr", char: "r") == [0, 1])
