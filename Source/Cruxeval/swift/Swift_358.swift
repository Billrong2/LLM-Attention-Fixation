func f(text: String, value: String) -> String {
    var indexes = [Int]()
    for i in 0..<text.count {
        let currentIndex = text.index(text.startIndex, offsetBy: i)
        if text[currentIndex] == Character(value) && (i == 0 || text[text.index(currentIndex, offsetBy: -1)] != Character(value)) {
            indexes.append(i)
        }
    }

    if indexes.count % 2 == 1 {
        return text
    }

    let startIndex = text.index(text.startIndex, offsetBy: indexes[0] + 1)
    let endIndex = text.index(text.startIndex, offsetBy: indexes[indexes.count - 1])
    return String(text[startIndex..<endIndex])
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
            
assert(f(text: "btrburger", value: "b") == "tr")
