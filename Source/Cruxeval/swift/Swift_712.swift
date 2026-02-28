/// 
func f(text: String) -> [[String]] {
    var created: [[String]] = []
    for line in text.split(separator: "\n") {
        if line == "" {
            break
        }
        let reversedLine = Array(line.reversed())
        // Assuming flush is the index of the character to keep from the reversed line
        var flush = 0
        if flush < reversedLine.count {
            created.append([String(reversedLine[flush])])
        }
    }
    return Array(created.reversed())
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
            
assert(f(text: "A(hiccup)A") == [["A"]])
