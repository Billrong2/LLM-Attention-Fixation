func f(text: [String]) -> [[String]] {
    var ls: [[String]] = []
    for x in text {
        ls.append(x.split(separator: "\n").map { String($0) })
    }
    return ls
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
            
assert(f(text: ["Hello World\n\"I am String\""]) == [["Hello World", "\"I am String\""]])
