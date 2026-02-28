func f(s: String, n: Int) -> [String] {
    let ls = s.split(separator: " ").map { String($0) }
    var out: [String] = []
    var lsCopy = ls
    while lsCopy.count >= n {
        out.append(contentsOf: Array(lsCopy.suffix(n)))
        lsCopy = Array(lsCopy.dropLast(n))
    }
    return lsCopy + ["\(out.joined(separator: "_"))"]
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
            
assert(f(s: "one two three four five", n: 3) == ["one", "two", "three_four_five"])
